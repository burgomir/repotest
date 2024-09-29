import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { UpdateBalanceDto } from './dto/updateBalance.dto';
import { PlayersType } from 'src/helpers/types/players.type';
import { GetTopPlayersResponse } from './responses/getTopPlayers.response';
import { OrcService } from '../orc/orc.service';
import { CreatePlayerOrcDto } from '../orc/dto/createPlayerOrc.dto';
import { ConfigService } from '@nestjs/config';
import { UpdateBalanceResponse } from './responses/updateBalance.response';
import { ProfitCommonService } from '../profitCommon/profitCommon.service';
import { NotificationGateway } from '../socket/gateways/notification.gateway';
import { GetTopPlayers } from './dto/getTopPlayers.query';
import { ProfitType } from '@prisma/client';
import { BalanceService } from '../balance/balance.service';
import { startOfDay, subDays } from 'date-fns';
import { CheckPlayerExistsResponse } from './responses/checkPlayerExists.reponse';
import { TelegramService } from 'src/utils/telegram/telegram.service';
import { RewardService } from 'src/libs/reward/reward.service';

@Injectable()
export class PlayerService {
  private logger = new Logger(PlayerService.name);

  constructor(
    private orcService: OrcService,
    private rewardService: RewardService,
    private prismaService: PrismaService,
    private balanceService: BalanceService,
    private telegramService: TelegramService,
    private profitCommonService: ProfitCommonService,
    private readonly notificationGateway: NotificationGateway,
  ) {}

  async getMe(currentUser: PlayersTokenDto): Promise<PlayersType> {
    this.logger.log(`Получение данных игрока с ID ${currentUser.id}`);
    const player = await this.prismaService.players.findUnique({
      where: { id: currentUser.id },
      include: {
        playersOrcs: true,
        playerProgress: true,
        playerRanks: { include: { rank: true } },
      },
    });
    if (!player) {
      this.logger.error(`Игрок с ID ${currentUser.id} не найден`);
      throw new NotFoundException('Player not found');
    }

    const cachedBalance = await this.balanceService.getBalance(player.id)

    player.balance += cachedBalance;
    if (player.playerProgress.length != 0) {
      player.playerProgress.at(-1).progress += cachedBalance;
    }

    return player;
  }

  async updateBalance(
    currentUser: PlayersTokenDto,
    dto: UpdateBalanceDto,
  ): Promise<UpdateBalanceResponse> {
    this.logger.log(`Обновление баланса игрока с ID ${currentUser.id}`);
  
    const player = await this.findPlayerById(currentUser.id);
  
    let playerOrc = await this.prismaService.playersOrcs.findUnique({
      where: { playerId: currentUser.id },
    });
  
    if (playerOrc.hp === 0) {
      throw new BadRequestException('Player orc is defeated');
    }
  
    if (dto.honey > playerOrc.hp) {
      dto.honey = playerOrc.hp;
    }

    let bossStreakHoney = 100000;
    let totalProfit = dto.honey;
    let newBossStreak = playerOrc.bossStreak;
  
    const now = new Date();
    const today = startOfDay(now);
    const oneDayAgo = new Date(now);
    oneDayAgo.setDate(oneDayAgo.getDate() - 1);
  
    if (playerOrc.hp - dto.honey <= 0) {
      this.logger.log(
        `Проверка победы над боссом для игрока с ID ${currentUser.id}`,
      );

      if (playerOrc.lastBossDate && playerOrc.lastBossDate >= today) {
        this.logger.error('Босс может быть побежден только один раз в день.');
        throw new ForbiddenException(
          'You can only defeat the boss once per day',
        );
      }
      
      
      this.logger.error('Current boss streak')
      this.logger.log(playerOrc.bossStreak)
      this.logger.error('New boss streak')
      this.logger.log(newBossStreak)
      this.logger.error('Boss streak honey')
      this.logger.log(bossStreakHoney)
      if (newBossStreak > 0) {
        bossStreakHoney += newBossStreak * 25000;
      }
      newBossStreak += 1;
      this.logger.log(bossStreakHoney)

      totalProfit += bossStreakHoney;
      
      let rewardRarity;
      let rewardNctr;
      let rewardCrystal;

      const referralsCount = await this.prismaService.referrals.count({
        where: { referrerId: currentUser.id }
      })

      const totalQuests = await this.prismaService.quests.count();
      const totalPlayersQuests = await this.prismaService.playersQuests.count({
        where: { playerId: player.id }
      })

      const reward = await this.rewardService.getRewardFromCurrentSegment(playerOrc.bossStreak, referralsCount, totalQuests, totalPlayersQuests)

      if (reward && (reward.nctr !== undefined || reward.crystal !== undefined)) {
        if (reward.nctr !== undefined) {
          rewardRarity = 'Legendary';
        } else if (reward.crystal !== undefined) {
          rewardRarity = 'Rare';
        } else {
          rewardRarity = 'Common';
        }
      
        rewardNctr = reward.nctr ?? 0;
        rewardCrystal = reward.crystal ?? 0;
      
        await this.prismaService.players.update({
          where: { id: currentUser.id },
          data: {
            ...(reward.nctr !== undefined && { balance_nctr: { increment: reward.nctr } }),
            ...(reward.crystal !== undefined && { balance_crystal: { increment: reward.crystal } })
          }
        });
      }
      
      await this.notificationGateway.sendBossKillNotification(
        currentUser.id,
        'You have killed boss!',
        newBossStreak,
        bossStreakHoney,
        rewardRarity,
        rewardNctr,
        rewardCrystal
      );
  
      this.logger.log(
        `Обновлен стрик побед. Новый стрик: ${newBossStreak}. Установлено здоровье босса: ${dto.honey}`,
      );
  
      await this.prismaService.playersOrcs.update({
        where: { playerId: currentUser.id },
        data: {
          lastBossDate: now,
          bossStreak: newBossStreak,
          hp: 0, 
        },
      });
    } else {
      await this.prismaService.playersOrcs.update({
        where: { playerId: currentUser.id },
        data: {
          hp: playerOrc.hp - dto.honey,
        },
      });
    }
  
    await this.prismaService.players.update({
      where: { id: player.id },
      data: {
        balance: { increment: totalProfit },
        honeyLatest: dto.honeyLatest,
      },
    });
  
    await this.profitCommonService.calculateProfit(player.id, dto.honey);
    await this.profitCommonService.writeProfit(
      player.id,
      dto.honey,
      ProfitType.click,
    );
    if (bossStreakHoney > 0) {
      await this.profitCommonService.calculateProfit(player.id, bossStreakHoney);
      await this.profitCommonService.writeProfit(
        player.id,
        bossStreakHoney,
        ProfitType.bossKill,
      );
    }
  
    this.logger.log(
      `Баланс игрока с ID ${currentUser.id} обновлен. Добавлено ${totalProfit}. Новый баланс: ${player.balance + totalProfit}`,
    );
  
    return {
      message: 'Balance updated successfully!',
      battle: {
        newBalance: player.balance + totalProfit,
        bossStreak: newBossStreak,
        bossStreakHoney,
      },
    };
  }
  

  async startFarming(currentUser: PlayersTokenDto) {
    this.logger.log(`Игрок с ID ${currentUser.id} начинает фарминг`);

    const player = await this.findPlayerById(currentUser.id);
    const currentDate = new Date();

    if (player.farmingEndDate && currentDate < player.farmingEndDate) {
      throw new ForbiddenException(
        'Фарминг уже начат. Подождите, пока текущий период завершится.',
      );
    }

    const farmingEndDate = new Date(currentDate.getTime() + 4 * 60 * 60 * 1000);
    const bonusAmount = player.balance * 0.005;

    if (bonusAmount === 0)
      throw new BadRequestException(
        'Your farming profit is 0. Earn honey to start farming',
      );

    await this.prismaService.players.update({
      where: { id: player.id },
      data: {
        farmingDate: currentDate,
        farmingEndDate: farmingEndDate,
        balance: { increment: bonusAmount },
      },
    });

    await this.profitCommonService.writeProfit(
      player.id,
      bonusAmount,
      ProfitType.farming,
    );

    await this.profitCommonService.calculateProfit(player.id, bonusAmount);

    this.logger.log(`Игрок с ID ${currentUser.id} успешно начал фарминг`);
    return {
      message: `Farm started successfully, honeyEarned: ${bonusAmount}`,
    };
  }

  private async findPlayerById(playerId: string): Promise<PlayersType> {
    this.logger.log(`Поиск игрока с ID ${playerId}`);
    const player = await this.prismaService.players.findUnique({
      where: { id: playerId },
    });
    if (!player) {
      this.logger.error(`Игрок с ID ${playerId} не найден`);
      throw new NotFoundException('Player not found');
    }
    return player;
  }

  async getTopPlayers(query: GetTopPlayers): Promise<GetTopPlayersResponse> {
    let { take = 30, page = 1 } = query;
    this.logger.log('Получение топ игроков');

    const maxPlayers = 100;
    const totalPages = Math.ceil(maxPlayers / take);
    if (page > totalPages) {
      page = totalPages;
    }

    if (page === totalPages) {
      take = maxPlayers % take || take;
    }

    const skip = (page - 1) * 30;

    const players = await this.prismaService.players.findMany({
      orderBy: { balance: 'desc' },
      select: { id: true, userName: true, balance: true, nickName: true },
      take: take,
      skip: skip,
    });

    players.forEach(async player => {
      var cachedBalance = await this.balanceService.getBalance(player.id);
      player.balance += cachedBalance
    });

    const rankedPlayers = players.map((player, index) => ({
      userName: player.nickName ? null : player.userName,
      nickName: player.nickName,
      balance: player.balance,
      rank: skip + index + 1,
    }));

    this.logger.log('Топ игроков успешно получен');

    return {
      currentPage: page,
      players: rankedPlayers,
    };
  }

  async getPlayerByTelegramId(telegramId: string): Promise<PlayersType> {
    const player = await this.prismaService.players.findFirst({
      where: { tgId: telegramId },
    });

    if (!player) throw new NotFoundException('Player not found!');

    return player;
  }

  async getPlayerBalance(userId: string) {
    const user = await this.prismaService.players.findUnique({
      where: { id: userId },
    });

    return user;
  }

  async checkPlayerExists(resource: string, telegramId: string): Promise<CheckPlayerExistsResponse> {
    switch (resource) { 
      case 'telegram_channel': 
        return {
          resource,
          isExists: await this.telegramService.checkSubscription(telegramId, 'subschannel_test'),
        };

      case 'telegram_channel_cis': 
        return {
          resource,
          isExists: await this.telegramService.checkSubscription(telegramId, 'CIS_CHANNEL_HERE'),
        };
      
      case 'telegram_group':
        return {
          resource,
          isExists: await this.telegramService.checkSubscription(telegramId, 'working_front_2_group'),
        };
      
      case 'telegram_bot':
        const playerExists = await this.prismaService.players.findFirst({
          where: { tgId: telegramId },
        }) !== null;
  
        return {
          resource,
          isExists: playerExists,
        };
      
      default:
        throw new NotFoundException('Resource not found!');
    }
  }  
}
