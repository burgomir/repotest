import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { Cron, CronExpression } from '@nestjs/schedule';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { startOfDay, subDays } from 'date-fns';
import { BalanceService } from 'src/components/balance/balance.service';
import { PlayerService } from 'src/components/player/player.service';
import { PlayersTokenDto } from 'src/components/token/dto/token.dto';
import { UpdateBalanceDto } from 'src/components/player/dto/updateBalance.dto';
import { TelegramService } from 'src/utils/telegram/telegram.service';
import { RewardService } from '../reward/reward.service';

@Injectable()
export class TasksService {
  private readonly logger = new Logger(TasksService.name);

  constructor(
    private prismaService: PrismaService,
    private balanceService: BalanceService,
    private playerService: PlayerService,
    private telegramService: TelegramService, 
    private rewardService: RewardService,
  ) {}

  @Cron(CronExpression.EVERY_DAY_AT_MIDNIGHT, { timeZone: 'Etc/UTC' })
  async handleResetRewardCounters() {
    try {
      this.rewardService.resetRewards()
    } catch (error) {
      console.log(error)
    }
  }

  @Cron(CronExpression.EVERY_DAY_AT_MIDNIGHT, { timeZone: 'Etc/UTC' })
  async handleBossDefeat() {
    this.logger.log('Начало обработки побед над боссом');
    
    const today = startOfDay(new Date());
    const yesterday = subDays(today, 1);
  
    try {
      this.logger.log('Получение всех игроков');
      
      const allPlayers = await this.prismaService.playersOrcs.findMany();
  
      const playersWhoKilledBossYesterday = [];
      const playersWhoDidNotKillBossYesterday = [];
  
      allPlayers.forEach(player => {
        if (player.lastBossDate === null) {}
        else if (player.lastBossDate && today > player.lastBossDate && player.lastBossDate >= yesterday) {
          playersWhoKilledBossYesterday.push(player);
        } else if (player.lastBossDate && yesterday > player.lastBossDate) {
          playersWhoDidNotKillBossYesterday.push(player);
        }
      });
  
      this.logger.log(
        `Найдено ${playersWhoKilledBossYesterday.length} игроков, убивших босса вчера`
      );
  
      if (playersWhoKilledBossYesterday.length > 0) {
        await this.prismaService.playersOrcs.updateMany({
          where: {
            id: {
              in: playersWhoKilledBossYesterday.map(player => player.id)
            }
          },
          data: {
            hp: 5000
          }
        });
      }
  
      this.logger.log(
        `Найдено ${playersWhoDidNotKillBossYesterday.length} игроков, которые не убивали босса вчера`
      );
  
      if (playersWhoDidNotKillBossYesterday.length > 0) {
        await this.prismaService.playersOrcs.updateMany({
          where: {
            id: {
              in: playersWhoDidNotKillBossYesterday.map(player => player.id)
            }
          },
          data: {
            hp: 5000,
            bossStreak: 0,
            lastBossDate: null
          }
        });
      }
  
      this.logger.log('Обработка побед над боссом завершена успешно');
    } catch (error) {
      this.logger.error('Ошибка при обработке побед над боссом', error);
    }
  }

  @Cron('*/2 * * * * *')
  async handleCron() {
    this.logger.debug('Запуск задачи по обновлению баланса пользователей');

    const keys = await this.balanceService.getAllBalanceKeys();
    if (keys.length === 0) return;
    for (const key of keys) {
      const userId = key.split(':')[1];
      let balance = await this.balanceService.getBalance(userId);
      if (!balance || balance === 0) return;
      const user = await this.prismaService.players.findUnique({
        where: { id: userId },
      });
      if (!user) return;
      const currentUser: PlayersTokenDto = {
        id: user.id,
        referredById: user.referredById,
        userName: user.userName,
        tgId: user.tgId,
      };

      const updateBalanceDto: UpdateBalanceDto = {
        honey: balance,
        honeyLatest: balance,
      };

      await this.balanceService.deleteBalance(userId);

      await this.playerService.updateBalance(currentUser, updateBalanceDto);

      this.logger.debug(
        `Обновлен баланс для пользователя ${userId}: ${balance}`,
      );
    }
  }

  // @Cron('0 */3 * * *') // Every 3 hours
  // @Cron('*/2 * * * * *') // Every 2 seconds for test
  // async checkPlayerSubscriptions() {
  //   this.logger.debug('Запуск задачи по проверке подписки пользователей на канал');

  //   try {
  //     const incompleteQuests = await this.prismaService.playersQuests.findMany({
  //       where: {
  //         isCompleted: false,
  //         createdAt: {
  //           lt: new Date(),
  //         },
  //         completedAt: {
  //           gt: new Date(),
  //         },
  //       },
  //       include: { quest: true },
  //     });

  //     if (!incompleteQuests) {
  //       return;
  //     }

  //     for (const quest of incompleteQuests) {
  //       const user = await this.prismaService.players.findUnique({
  //         where: { id: quest.playerId },
  //       });
        
  //       if (!user) {
  //         this.logger.warn(`Пользователь с ID ${quest.playerId} не найден`);
  //         continue;
  //       }

  //       const channelUsername = quest.quest.link.split('https://t.me/')[1];
  //       const isSubscribed = await this.telegramService.checkSubscription(user.tgId, channelUsername);

  //       if (!isSubscribed) {
  //         this.logger.warn(`Пользователь с ID ${user.id} не подписан на канал ${quest.quest.link}`);
          
  //         await this.prismaService.playersQuests.delete({
  //           where: { id: quest.id },
  //         });

  //         await this.telegramService.sendMessage(
  //           user.tgId,
  //           `You have been unsubscribed from the channel associated with the quest. As a result, your quest completion has been revoked.`,
  //         );
  //       }
  //     }

  //     this.logger.debug('Задача по проверке подписки пользователей на канал завершена');
  //   } catch (error) {
  //     this.logger.error('Ошибка при проверке подписки пользователей', error);
  //   }
  // }
}
