import {
  ConflictException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { GetReferralsQuery } from './dto/getReferralsQuery.dto';
import { CreateReferralQuestDto } from './dto/createReferralRequest.dto';
import { UpdateReferralQuestDto } from './dto/updateReferralRequest.dto';
import { CreateNewReferralBonusDto } from './dto/createNewReferralBonus.dto';
import { PlayerProgressDto } from '../playerProgress/dto/progress.dto';
import { ProfitCommonService } from '../profitCommon/profitCommon.service';
import { PlayerProgressService } from '../playerProgress/playerProgress.service';
import { GetReferralQuestsResponse } from './responses/getReferralQuests.response';
import { ProfitType, progressType } from '@prisma/client';

@Injectable()
export class ReferralsService {
  private logger = new Logger(ReferralsService.name);

  constructor(
    private prismaService: PrismaService,
    private profitCommonService: ProfitCommonService,
    private playerProgressService: PlayerProgressService,
  ) {}

  async calculateNewReferralProfit(
    dto: CreateNewReferralBonusDto,
    referrerId: string,
    referralId: string,
  ) {
    const referrer = await this.findPlayerById(referrerId);
    const referral = await this.findPlayerById(referralId);
    const referralEarlyProfit =
      await this.prismaService.referralsEarlyBonuses.create({
        data: {
          playerId: referrer.id,
          accountType: dto.accountType,
          honey: dto.honey,
        },
      });

    const referralProfit = await this.prismaService.referralsProfit.findUnique({
      where: { playerId: referrer.id },
    });

    await this.prismaService.players.update({
      where: { id: referral.id },
      data: { balance: { increment: dto.honey } },
    });

    await this.profitCommonService.writeProfit(
      referral.id,
      dto.honey,
      ProfitType.referralProfit,
    );

    if (!referralProfit) {
      await this.prismaService.referralsProfit.create({
        data: {
          playerId: referrer.id,
          honey: referralEarlyProfit.honey,
        },
      });

      this.logger.log(`Добавлена прибыль от реферала для ID: ${referrer.id}`);
      return { message: 'Прибыль от реферала добавлена' };
    }

    await this.prismaService.referralsProfit.update({
      where: { id: referralProfit.id },
      data: { honey: { increment: referralEarlyProfit.honey } },
    });
    this.logger.log(`Добавлена прибыль от реферала для ID: ${referrer.id}`);
    return { message: 'Прибыль от реферала добавлена' };
  }

  async getReferrals(currentUser: PlayersTokenDto, query?: GetReferralsQuery) {
    const { take = 10, page = 1 } = query || {};

    const player = await this.findPlayerById(currentUser.id);

    const referrals = await this.prismaService.referrals.findMany({
      where: { referrerId: currentUser.id },
      select: { players: { select: { userName: true, balance: true } } },
      orderBy: { players: { balance: 'desc' } },
      take: take,
      skip: (page - 1) * take,
    });

    if (referrals.length === 0) {
      return { message: 'Referrals not found!' };
    }
    const totalCount = await this.prismaService.referrals.count({
      where: { referrerId: currentUser.id },
    });

    const earnedFromReferralsResult =
      await this.prismaService.referralsProfit.findFirst({
        where: { playerId: currentUser.id },
      });

    const earnedFromReferralsNow = earnedFromReferralsResult?.honey ?? 0;

    const earnedFromReferralsTotal = player.totalReferralProfit ?? 0;

    const totalPages = Math.ceil(totalCount / take);

    this.logger.log(
      `Получены рефералы для пользователя с ID: ${currentUser.id}`,
    );

    return {
      totalCount,
      referrals,
      earnedFromReferralsNow,
      earnedFromReferralsTotal,
      totalPages,
    };
  }

  async collectReferralProfit(currentUser: PlayersTokenDto) {
    const player = await this.findPlayerById(currentUser.id);

    const referralProfit = await this.prismaService.referralsProfit.findFirst({
      where: { playerId: player.id },
    });

    if (!referralProfit) {
      return {
        message: `Прибыль от рефералов собрана сумма ${referralProfit.honey}`,
        profit: referralProfit.honey,
      };
    }

    if (referralProfit.honey === 0) {
      return {
        message: `Прибыль от рефералов собрана сумма ${referralProfit.honey}`,
        profit: referralProfit.honey,
      };
    }

    await this.prismaService.players.update({
      where: { id: player.id },
      data: { balance: { increment: referralProfit.honey } },
    });

    await this.profitCommonService.writeProfit(
      player.id,
      referralProfit.honey,
      ProfitType.referralProfit,
    );

    await this.prismaService.referralsProfit.update({
      where: { playerId: player.id },
      data: { honey: 0 },
    });

    await this.prismaService.players.update({
      where: { id: player.id },
      data: { totalReferralProfit: { increment: referralProfit.honey } },
    });

    await this.profitCommonService.calculateProfit(
      player.id,
      referralProfit.honey,
    );

    this.logger.log(
      `Собрана прибыль от рефералов для игрока с ID: ${player.id}`,
    );
    return {
      message: `Прибыль от рефералов собрана сумма ${referralProfit.honey}`,
      profit: referralProfit.honey,
    };
  }

  private async findPlayerById(playerId: string) {
    const player = await this.prismaService.players.findUnique({
      where: { id: playerId },
    });
    if (!player) {
      this.logger.error(`Игрок не найден с ID: ${playerId}`);
      throw new NotFoundException('Игрок не найден!');
    }
    return player;
  }

  async createReferralQuest(dto: CreateReferralQuestDto) {
    const referralQuest = await this.prismaService.referralsQuest.create({
      data: { ...dto },
    });

    this.logger.log(`Создано задание реферала с ID: ${referralQuest.id}`);
    return referralQuest;
  }

  async updateReferralQuest(
    referralQuestId: string,
    dto: UpdateReferralQuestDto,
  ) {
    const referralQuest = await this.findReferralQuestById(referralQuestId);
    const updatedReferralQuest = await this.prismaService.referralsQuest.update(
      {
        where: { id: referralQuest.id },
        data: { ...dto },
      },
    );

    this.logger.log(`Обновлено задание реферала с ID: ${referralQuest.id}`);
    return {
      message: 'Задание реферала успешно обновлено',
      updatedReferralQuest,
    };
  }

  async deleteReferralQuest(referralQuestId: string) {
    const referralQuest = await this.findReferralQuestById(referralQuestId);
    await this.prismaService.referralsQuest.delete({
      where: { id: referralQuest.id },
    });

    this.logger.log(`Удалено задание реферала с ID: ${referralQuest.id}`);
    return { message: 'Задание реферала успешно удалено' };
  }

  async getReferralQuests(
    currentUser: PlayersTokenDto,
  ): Promise<GetReferralQuestsResponse> {
    const playerReferralQuests =
      await this.prismaService.referralsQuestProfit.findMany({
        where: { playerId: currentUser.id },
        select: { referralsQuestId: true, claimed: true },
      });

    const completedQuestIds = new Set(
      playerReferralQuests.map((quest) => quest.referralsQuestId),
    );

    const claimedQuestIds = new Set(
      playerReferralQuests
        .filter((quest) => quest.claimed)
        .map((quest) => quest.referralsQuestId),
    );

    const referralQuests = await this.prismaService.referralsQuest.findMany();

    const questsWithCompletionStatus = referralQuests.map((quest) => {
      const isCompleted = completedQuestIds.has(quest.id);
      const isClaimed = claimedQuestIds.has(quest.id);

      return {
        ...quest,
        isCompleted,
        isClaimed,
      };
    });

    this.logger.log(
      `Получено ${questsWithCompletionStatus.length} заданий рефералов`,
    );

    let currentLevel = 0;
    let currentQuest = null;
    let nextQuest = null;

    for (const quest of questsWithCompletionStatus) {
      if (!quest.isCompleted || !quest.isClaimed) {
        if (!currentQuest) {
          currentQuest = quest;
          currentLevel = quest.level;
        } else if (nextQuest === null && quest.level > currentLevel) {
          nextQuest = quest;
        }
      }
    }

    if (currentQuest && currentQuest.isCompleted && !currentQuest.isClaimed) {
      nextQuest =
        referralQuests.find(
          (quest) => quest.level === currentQuest.level + 1,
        ) || null;
    }

    if (!currentQuest) {
      nextQuest =
        referralQuests.find((quest) => quest.level === currentLevel + 1) ||
        null;
    }

    return {
      currentLevel: currentLevel,
      nextQuest: nextQuest,
      quests: questsWithCompletionStatus,
    };
  }

  private async findReferralQuestById(referralQuestId: string) {
    const referralQuest = await this.prismaService.referralsQuest.findUnique({
      where: { id: referralQuestId },
    });
    if (!referralQuest) {
      this.logger.error(`Задание реферала не найдено с ID: ${referralQuestId}`);
      throw new NotFoundException('Задание реферала не найдено');
    }
    return referralQuest;
  }

  async handleNewRegistration(playerId: string) {
    const playerReferralQuests =
      await this.prismaService.referralsQuestProfit.findMany({
        where: { playerId },
        select: { referralsQuestId: true },
      });

    const referralQuests = await this.prismaService.referralsQuest.findMany();

    const completedQuestIds = new Set(
      playerReferralQuests.map((quest) => quest.referralsQuestId),
    );

    const incompleteReferralQuests = referralQuests.filter(
      (quest) => !completedQuestIds.has(quest.id),
    );
    if (incompleteReferralQuests.length === 0) {
      return { message: 'All referral quests completed' };
    }

    const playerProgressDto: PlayerProgressDto = {
      type: progressType.Referral,
      progress: 1,
    };
    const { playerProgress } =
      await this.playerProgressService.createProgressOrUpdate(
        playerProgressDto,
        playerId,
      );
    for (const referralQuest of incompleteReferralQuests) {
      if (playerProgress.progress >= referralQuest.referralCount) {
        await this.prismaService.referralsQuestProfit.create({
          data: {
            playerId: playerProgress.playerId,
            referralsQuestId: referralQuest.id,
            reward: referralQuest.reward,
            referralCount: playerProgress.progress,
          },
        });
        await this.prismaService.playerProgress.delete({
          where: { id: playerProgress.id },
        });

        const resetProgressDto: PlayerProgressDto = {
          type: progressType.Referral,
          progress: 0,
        };

        await this.playerProgressService.createProgressOrUpdate(
          resetProgressDto,
          playerProgress.playerId,
        );

        return { message: 'Referral reward added' };
      }
    }

    this.logger.log(
      `Обработана новая регистрация для игрока с ID: ${playerId}`,
    );
  }

  async getReferralQuestsProfit(
    player: PlayersTokenDto,
    referralQuestId: string,
  ) {
    const referralProfit =
      await this.prismaService.referralsQuestProfit.findFirst({
        where: {
          playerId: player.id,
          referralsQuestId: referralQuestId,
        },
      });
    if (referralProfit?.claimed)
      throw new ConflictException('Referral quest reward already claimed!');
    if (!referralProfit)
      throw new NotFoundException('Referral quest not completed');

    await this.prismaService.referralsQuestProfit.update({
      where: { id: referralProfit.id },
      data: { claimed: true },
    });

    if (referralProfit.reward === 0)
      throw new ConflictException('You cannot claim 0 honey reward');

    await this.prismaService.players.update({
      where: { id: player.id },
      data: { balance: { increment: referralProfit.reward } },
    });

    await this.profitCommonService.calculateProfit(
      player.id,
      referralProfit.reward,
    );

    this.logger.log(
      `Собраны прибыли от заданий рефералов для игрока с ID: ${player.id}`,
    );
    return {
      message: 'Начислены вознаграждения на баланс',
      reward: referralProfit.reward,
    };
  }
}
