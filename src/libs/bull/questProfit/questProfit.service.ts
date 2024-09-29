import { InjectQueue } from '@nestjs/bull';
import {
  ConflictException,
  Injectable,
  ForbiddenException,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { ProfitType } from '@prisma/client';
import { Queue } from 'bull';
import { ProfitCommonService } from 'src/components/profitCommon/profitCommon.service';
import { PlayersTokenDto } from 'src/components/token/dto/token.dto';
import { SuccessMessageType } from 'src/helpers/common/successMessage.type';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { TelegramService } from 'src/utils/telegram/telegram.service';
import { TaskType } from 'src/helpers/constants/taskTypeEnum';
import axios from 'axios';

@Injectable()
export class QuestProfitService {
  private logger = new Logger(QuestProfitService.name);

  constructor(
    @InjectQueue('completeQuest') private readonly completeQuestQueue: Queue,
    private prismaService: PrismaService,
    private profitCommonService: ProfitCommonService,
    private telegramService: TelegramService,
  ) { }

  async completeQuest(currentUser: PlayersTokenDto, questId: string): Promise<SuccessMessageType> {
    const quest = await this.getQuestWithTasks(questId);
    this.checkQuestLimit(quest);

    const playerQuest = await this.getPlayerQuest(currentUser.id, questId);
    if (playerQuest) return;

    await this.processQuestTasks(quest.questTasks, currentUser);

    await this.incrementQuestLimit(questId);
    await this.createPlayerQuest(currentUser.id, questId);

    await this.addQuestCompletionJob(currentUser.id, questId);

    return { message: 'Quest completed, please wait for the specified time to get reward' };
  }

  private async getQuestWithTasks(questId: string) {
    return await this.prismaService.quests.findUnique({
      where: { id: questId },
      include: { questTasks: true },
    }) || this.throwNotFoundException('Quest not found');
  }

  private checkQuestLimit(quest: any): void {
    if (quest.totalLimit !== 0 && quest.currentLimit >= quest.totalLimit) {
      throw new ForbiddenException('The limit has been reached');
    }
  }

  private async getPlayerQuest(playerId: string, questId: string) {
    return await this.prismaService.playersQuests.findFirst({
      where: { playerId, questId },
      include: { quest: { include: { questTasks: true } } },
    });
  }

  private async processQuestTasks(tasks: any[], currentUser: PlayersTokenDto): Promise<void> {
    for (const task of tasks) {
      let playerTask = await this.prismaService.playersTasks.findFirst({
        where: { playerId: currentUser.id, taskId: task.id },
      });

      // if (playerTask?.isCompleted) continue;

      if (!playerTask) {
        await this.updatePlayerTaskStatus(playerTask, currentUser.id, task.id, true);
        playerTask = await this.prismaService.playersTasks.findFirst({
          where: { playerId: currentUser.id, taskId: task.id },
        });
      }

      const questTask = await this.prismaService.questTask.findFirst({
        where: { id: playerTask.taskId }
      })

      if (task.type === TaskType.SUBSCRIBE_TELEGRAM) {
        await this.checkTelegramSubscription(currentUser.tgId, task.link, playerTask.id, questTask.questId);
      } else if (task.type === TaskType.SUBSCRIBE_PARTNER) {
        await this.checkPartnerSubscription(currentUser.tgId, task.link, playerTask.id);
      }

      await this.createOrUpdatePlayerTask(playerTask, currentUser.id, task.id);
    }
  }

  private async checkTelegramSubscription(tgId: string, link: string, taskId: string, questId: string): Promise<void> {
    const channelUsername = link.split('https://t.me/')[1];
    if (channelUsername) {
      const isSubscribed = await this.telegramService.checkSubscription(tgId, channelUsername);
      if (!isSubscribed) {
        try {
          if (questId) {
            const player = await this.prismaService.players.findFirst({
              where: { tgId: tgId }
            });

            if (player) {
              const playerQuest = await this.prismaService.playersQuests.findFirst({
                where: { questId: questId, playerId: player.id }
              });

              if (playerQuest) {
                await this.prismaService.playersQuests.delete({
                  where: { id: playerQuest.id }
                });
              }
            }
          }
          console.log(questId)
          await this.prismaService.playersTasks.delete({
            where: { id: taskId }
          });
        } catch (error) {
          console.log('error', error);
        }

        throw new ForbiddenException('You must be subscribed to the channel to complete this task');
      }
    }
  }


  private async createOrUpdatePlayerTask(playerTask: any, playerId: string, taskId: string): Promise<void> {
    const completedAt = new Date(Date.now() + 5 * 1000);
    let isCompleted;
    if (playerTask) {
      isCompleted = playerTask.isCompleted
    } else {
      isCompleted = false;
    }
    const data = { isCompleted: isCompleted, completedAt, createdAt: new Date() };
    if (playerTask) {
      await this.prismaService.playersTasks.update({ where: { id: playerTask.id }, data });
    } else {
      await this.prismaService.playersTasks.create({ data: { player: { connect: { id: playerId } }, task: { connect: { id: taskId } }, ...data } });
    }
  }

  private async checkPartnerSubscription(tgId: string, link: string, taskId: string, questId?: string): Promise<boolean> {
    let apiUrl: string;
    let response;
    let playerTask
    let headers: Record<string, string> = {};

    if (link === 'https://t.me/slimewifhat_bot') {
      apiUrl = `https://slime-backend-na34.onrender.com/api/checkUserExistsInBot/${tgId}`;

      headers = {};
    } else if (link === 'https://t.me/slimewifcoingroup') {
      apiUrl = `https://slime-backend-na34.onrender.com/api/checkUserExistsInChannel/${tgId}`;

      headers = {};

    } else if (link === 'https://t.me/bullsonton_bot/bulls?startapp=AMKUJIS') {
      apiUrl = `https://starportal.space:8008/tasks/checkJoinStatus?tgId=${tgId}`;

      headers = {
        "x-api-header": "e1fb9640bb6befdbf775334e7489d55ecbb3d461e957da5bfbc54ee31cd184df"
      };
    } else if (link === 'https://t.me/QappiMinerBot?start=7266842224') {
      apiUrl = `https://api.clicker.qappi.com/api/checkUser?id=${tgId}&partner=bee_verse&token=f69FTq94Fp7ByoRN55z4SQyKgcEdemPzTK5dtre4`;

      headers = {};
    } else if (link === 'https://t.me/play_smartest_bot/quiz?startapp=utmbeeverse') {
      apiUrl = `https://play.smartest.bot/app/verify_membership/${tgId}`;

      headers = {
        'Authorization': 'Bearer 1e25881748095d4446d565d5d3dc4edf16460e5d513aa469e85be6902e7b1a2a'
      };
    } else if (link === 'https://t.me/tg_4everland_bot/start?startapp=t-Alberrtt') {
      apiUrl = `https://booster.api.4everland.org/api/v1/account/tg/${tgId}/exist`;

      headers = {};
    } else if (link === 'https://t.me/Geckoshi_bot') {
      apiUrl = `https://geckoshi-prod.up.railway.app/public/user-exits?id=${tgId}`;
      headers = {
        'Authorization': 'Bearer DhIQXtpbvjroQojvVyXXMYALYyrxqzrzoKcFCzquqFNgZTbHTiqEDAAxWzcCaVUEENPxyKIYGlFKtiIEnOEXUKyojkEfZNbtmYtjxgBCfwpMoeeAdiZeeSLbIZbNODyZahrmOlQmKByZtchWKgNfTopEmCtoyTwFdTNVQJqKIvNBDNfCudRlAYddpGRCayjmvAfQoTYw',
      };
    } else if (link === 'https://t.me/gemsee_bot') {
      apiUrl = `https://gemsee.xyz/dev/checkuser/${tgId}`;
      headers = {
        'Authorization': 'GemseeDev',
        'Version': '1.0',
        'Content-Type': 'application/json'
      };
    } else {
      playerTask = await this.prismaService.playersTasks.findFirst({
        where: { id: taskId }
      })
      if (playerTask) {
        await this.prismaService.playersTasks.delete({
          where: { id: taskId }
        })
      }
      throw new ForbiddenException('Partner API not found!');
    }

    try {
      response = await axios.get(apiUrl, { headers });
      console.log(response)
    } catch (error) {
      playerTask = await this.prismaService.playersTasks.findFirst({
        where: { id: taskId }
      })
      if (playerTask) {
        await this.prismaService.playersTasks.delete({
          where: { id: taskId }
        })
      }
      throw new ForbiddenException('You must be subscribed to the channel/bot to complete this task');
    }
    try {
      if (link === 'https://t.me/slimewifhat_bot' || link === 'https://t.me/slimewifcoingroup') {
        if (response.data.status === 'success' && response.data.message === 'UserExists') {
          return true;
        } else {
          playerTask = await this.prismaService.playersTasks.findFirst({
            where: { id: taskId }
          })
          if (playerTask) {
            await this.prismaService.playersTasks.delete({
              where: { id: taskId }
            })
          }
          throw new ForbiddenException('You must be subscribed to the channel/bot to complete this task');
        }
      } else if (link === 'https://t.me/Geckoshi_bot') {
        if (response.data.status === 'OK' && response.data.data.exists == true && response.data.data.registration_finished == true) {
          return true;
        } else {
          playerTask = await this.prismaService.playersTasks.findFirst({
            where: { id: taskId }
          })
          if (playerTask) {
            await this.prismaService.playersTasks.delete({
              where: { id: taskId }
            })
          }
          throw new ForbiddenException('You must be subscribed to the channel to complete this task');
        }
      } else if (link === 'https://t.me/QappiMinerBot?start=7266842224') {
        if (response.data.success == true && response.data.data.isMember == true) {
          return true;
        } else {
          playerTask = await this.prismaService.playersTasks.findFirst({
            where: { id: taskId }
          })
          if (playerTask) {
            await this.prismaService.playersTasks.delete({
              where: { id: taskId }
            })
          }
          throw new ForbiddenException('You must be subscribed to the channel to complete this task');
        }
      } else if (link === 'https://t.me/bullsonton_bot/bulls?startapp=AMKUJIS') {
        if (response.data.code == 200 && response.data.is_exists == true) {
          return true;
        } else {
          playerTask = await this.prismaService.playersTasks.findFirst({
            where: { id: taskId }
          })
          if (playerTask) {
            await this.prismaService.playersTasks.delete({
              where: { id: taskId }
            })
          }
          throw new ForbiddenException('You must be subscribed to the channel to complete this task');
        }
      } else if (link === 'https://t.me/tg_4everland_bot/start?startapp=t-Alberrtt') {
        if (response.data.code == 200 && response.data.message == 'success' && response.data.data == true) {
          return true;
        } else {
          playerTask = await this.prismaService.playersTasks.findFirst({
            where: { id: taskId }
          })
          if (playerTask) {
            await this.prismaService.playersTasks.delete({
              where: { id: taskId }
            })
          }
          throw new ForbiddenException('You must be subscribed to the channel to complete this task');
        }
      } else if (link === 'https://t.me/play_smartest_bot/quiz?startapp=utmbeeverse') {
        if (response.data.isInApp == true) {
          return true;
        } else {
          playerTask = await this.prismaService.playersTasks.findFirst({
            where: { id: taskId }
          })
          if (playerTask) {
            await this.prismaService.playersTasks.delete({
              where: { id: taskId }
            })
          }
          throw new ForbiddenException('You must be subscribed to the channel to complete this task');
        }
      } else if (link === 'https://t.me/gemsee_bot') {
        if (response.data.data === 'OK' && response.data.status == true && response.data.code == 200) {
          return true;
        } else {
          playerTask = await this.prismaService.playersTasks.findFirst({
            where: { id: taskId }
          })
          if (playerTask) {
            await this.prismaService.playersTasks.delete({
              where: { id: taskId }
            })
          }
          throw new ForbiddenException('You must be subscribed to the channel to complete this task');
        }
      } else {
        playerTask = await this.prismaService.playersTasks.findFirst({
          where: { id: taskId }
        })
        if (playerTask) {
          await this.prismaService.playersTasks.delete({
            where: { id: taskId }
          })
        }
        throw new ForbiddenException('Partner API not found!');
      }
    } catch (error) {
      console.log(error)
      playerTask = await this.prismaService.playersTasks.findFirst({
        where: { id: taskId }
      })
      if (playerTask) {
        await this.prismaService.playersTasks.delete({
          where: { id: taskId }
        })
      }
      throw new ForbiddenException('Error while parsing partner API response!');
    }
  }

  private async incrementQuestLimit(questId: string): Promise<void> {
    await this.prismaService.quests.update({
      where: { id: questId },
      data: { currentLimit: { increment: 1 } },
    });
  }

  private async createPlayerQuest(playerId: string, questId: string): Promise<void> {
    await this.prismaService.playersQuests.create({
      data: {
        playerId,
        questId,
        isCompleted: false,
        completedAt: new Date(Date.now() + 5 * 1000),
        createdAt: new Date(),
      },
    });
  }

  private async addQuestCompletionJob(playerId: string, questId: string): Promise<void> {
    await this.completeQuestQueue.add(
      'completeQuest',
      { playerId, questId },
      {
        delay: 5 * 1000,
        removeOnComplete: true,
        removeOnFail: true,
        backoff: { type: 'fixed', delay: 5000 },
      },
    );
  }

  private throwNotFoundException(message: string): never {
    throw new NotFoundException(message);
  }

  async completeTaskInQuest(currentUser: PlayersTokenDto, questId: string, taskId: string): Promise<SuccessMessageType> {
    const quest = await this.prismaService.quests.findUnique({
      where: { id: questId },
      include: { questTasks: true },
    });

    if (!quest) throw new NotFoundException('Quest not found');

    const task = quest.questTasks.find(t => t.id === taskId);
    if (!task) throw new NotFoundException('Task not found in the quest');

    const playerTask = await this.prismaService.playersTasks.findFirst({
      where: { playerId: currentUser.id, taskId },
    });

    if (playerTask?.isCompleted) {
      throw new ForbiddenException('Task is already completed by the player');
    }

    let isSubscribed;

    switch (task.type) {
      case TaskType.SUBSCRIBE_TELEGRAM:
        await this.checkTelegramSubscription(currentUser.tgId, task.link, taskId, questId);
        isSubscribed = true;
        break;
      case TaskType.SUBSCRIBE_PARTNER:
        isSubscribed = await this.checkPartnerSubscription(currentUser.tgId, task.link, taskId);
        break;
      case TaskType.OTHER:
        isSubscribed = true;
        break;
      default:
        throw new ForbiddenException('Unknown task type');
    }

    await this.updatePlayerTaskStatus(playerTask, currentUser.id, task.id, isSubscribed);

    return { message: isSubscribed.toString() };
  }

  private async updatePlayerTaskStatus(playerTask: any, playerId: string, taskId: string, isCompleted: boolean): Promise<void> {
    const currentTime = new Date();

    if (playerTask) {
      await this.prismaService.playersTasks.update({
        where: { id: playerTask.id },
        data: { isCompleted, completedAt: currentTime },
      });
    } else {
      await this.prismaService.playersTasks.create({
        data: {
          player: { connect: { id: playerId } },
          task: { connect: { id: taskId } },
          isCompleted,
          completedAt: currentTime,
          createdAt: currentTime,
        },
      });
    }
  }

  async handleCompleteQuestJob(job: any): Promise<{ message: string }> {
    const { playerId, questId } = job.data;
    this.logger.log(`Обработка задания по завершению квеста для игрока с ID ${playerId} и квеста с ID ${questId}`);

    const player = await this.prismaService.players.findUnique({ where: { id: playerId } });
    if (!player) return { message: 'Player not found' };

    const playerQuest = await this.prismaService.playersQuests.findFirst({
      where: { playerId, questId, isCompleted: false },
      include: { quest: { include: { questTasks: true } } },
    });

    if (!playerQuest) {
      this.logger.error(`Квест для игрока с ID ${playerId} и квеста с ID ${questId} не найден`);
      throw new NotFoundException('Player quest not found');
    }

    await this.processQuestTasks(playerQuest.quest.questTasks, player);

    await this.completeQuestAndRewardPlayer(playerQuest, player);

    this.logger.log(`Награда за квест с ID ${questId} успешно выдана игроку с ID ${playerId}`);

    return { message: 'Reward granted to player' };
  }

  private async completeQuestAndRewardPlayer(playerQuest: any, player: any): Promise<void> {
    await this.prismaService.playersQuests.update({
      where: { id: playerQuest.id },
      data: { isCompleted: true },
    });

    await this.prismaService.players.update({
      where: { id: playerQuest.playerId },
      data: { balance: { increment: playerQuest.quest.reward } },
    });

    await this.profitCommonService.writeProfit(player.id, playerQuest.quest.reward, ProfitType.quest);
    await this.profitCommonService.calculateProfit(player.id, playerQuest.quest.reward);
  }
}
