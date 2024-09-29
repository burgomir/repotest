import {
  Injectable,
  Logger,
  NotFoundException,
  LogLevel,
} from '@nestjs/common';
import { SuccessMessageType } from 'src/helpers/common/successMessage.type';
import { RankType } from 'src/helpers/types/rank.type';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { CreateRankDto } from './dto/createRank.dto';
import { UpdateRankDto } from './dto/updateRank.dto';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { ProfitCommonService } from '../profitCommon/profitCommon.service';
import { GetPlayerRanksType } from './responses/getPlayerRanks.response';
import { ProfitType } from '@prisma/client';

@Injectable()
export class RanksService {
  private logger = new Logger(RanksService.name);

  constructor(
    private readonly prismaService: PrismaService,
    private profitCommonService: ProfitCommonService,
  ) {}

  async create(rankDto: CreateRankDto): Promise<RankType> {
    this.logger.log('Создание нового ранга');
    const createdRank = await this.prismaService.ranks.create({
      data: rankDto,
    });
    this.logger.log(`Ранг с ID ${createdRank.id} успешно создан`);
    return createdRank;
  }

  async update(id: string, rankDto: UpdateRankDto): Promise<RankType> {
    this.logger.log(`Обновление ранга с ID ${id}`);
    const updatedRank = await this.prismaService.ranks.update({
      where: { id },
      data: rankDto,
    });
    this.logger.log(`Ранг с ID ${id} успешно обновлен`);
    return updatedRank;
  }

  async delete(id: string): Promise<SuccessMessageType> {
    this.logger.log(`Удаление ранга с ID ${id}`);
    await this.prismaService.ranks.delete({ where: { id } });
    this.logger.log(`Ранг с ID ${id} успешно удален`);
    return { message: 'Rank delete successfully' };
  }

  async getAll(): Promise<RankType[]> {
    this.logger.log('Получение всех рангов');
    const ranks = await this.prismaService.ranks.findMany();
    this.logger.log('Список всех рангов успешно получен');
    return ranks;
  }

  async findById(id: string): Promise<RankType> {
    this.logger.log(`Поиск ранга с ID ${id}`);
    const rank = await this.prismaService.ranks.findUnique({ where: { id } });
    if (!rank) {
      this.logger.error(`Ранг с ID ${id} не найден`);
      throw new NotFoundException('Rank not found');
    }
    this.logger.log(`Ранг с ID ${id} успешно найден`);
    return rank;
  }

  async getPlayerRanks(playerId: string): Promise<GetPlayerRanksType> {
    this.logger.log(`Получение рангов игрока с ID ${playerId}`);

    // Получаем все ранги игрока, ранги и прибыли от рангов
    const playerRanks = await this.prismaService.playerRanks.findMany({
      where: { playerId },
      include: { rank: true },
      orderBy: { achievedAt: 'asc' },
    });

    const allRanks = await this.prismaService.ranks.findMany({
      orderBy: { rank: 'asc' }, // Сортировка по уровню ранга
    });

    const rankProfit = await this.prismaService.playerRankProfit.findMany({
      where: { playerId },
    });

    // Создаем набор завершённых и собранных рангов
    const completedRankIds = new Set(playerRanks.map((pr) => pr.rankId));
    const collectedRankIds = new Set(
      rankProfit.filter((rp) => rp.isCollected).map((rp) => rp.rankId),
    );

    // Формируем массив рангов с статусами завершения и сбора
    const ranksWithCompletionStatus = allRanks.map((rank) => {
      const isCompleted = completedRankIds.has(rank.id);
      const isCollected = isCompleted ? collectedRankIds.has(rank.id) : false;

      return {
        rank: {
          id: rank.id,
          bonusAmount: rank.bonusAmount,
          description: rank.description,
          rank: rank.rank,
          name: rank.name,
          requiredAmount: rank.requiredAmount,
        },
        isCompleted,
        isCollected,
      };
    });

    this.logger.log(`Ранги игрока с ID ${playerId} успешно получены`);

    let currentLevel = 0;
    let currentRank = null;
    let nextRank = null;

    // Определяем текущий ранг и следующий
    for (const rank of ranksWithCompletionStatus) {
      if (rank.rank.rank === currentLevel) {
        currentRank = rank;
      } else if (rank.rank.rank === currentLevel + 1) {
        if (rank.isCompleted && rank.isCollected) {
          // Если текущий ранг завершён и собран, переходим к следующему
          currentLevel++;
          currentRank = rank;
          nextRank =
            ranksWithCompletionStatus.find(
              (r) => r.rank.rank === currentLevel + 1,
            ) || null;
        } else {
          // Если следующий ранг ещё не завершён, прекращаем искать
          nextRank = rank;
          break;
        }
      }
    }

    // Если текущий ранг завершён, но не собран, проверяем следующий
    if (currentRank && currentRank.isCompleted && !currentRank.isCollected) {
      nextRank =
        ranksWithCompletionStatus.find(
          (rank) => rank.rank.rank === currentRank.rank.rank + 1,
        ) || null;
    }

    // Если нет текущего ранга, находим первый завершённый ранг
    if (!currentRank) {
      nextRank =
        ranksWithCompletionStatus.find(
          (rank) =>
            rank.rank.rank === currentLevel + 1 &&
            rank.isCompleted &&
            rank.isCollected,
        ) || null;
    }

    if (!nextRank) {
      this.logger.log('Все ранги завершены и собраны.');
    }

    return {
      currentLevel: currentLevel,
      nextRank: nextRank
        ? {
            rank: nextRank.rank,
            isCompleted: nextRank.isCompleted,
            isCollected: nextRank.isCollected,
          }
        : null,
      ranks: ranksWithCompletionStatus,
    };
  }

  async collectRankProfit(currentUser: PlayersTokenDto, rankId: string) {
    const player = await this.prismaService.players.findUnique({
      where: { id: currentUser.id },
    });
    if (!player) throw new NotFoundException('Player not found!');

    const rankProfit = await this.prismaService.playerRankProfit.findFirst({
      where: { playerId: player.id, rankId: rankId, isCollected: false },
    });

    if (!rankProfit)
      throw new NotFoundException('Rank profit collected or not earned yet');

    await this.prismaService.players.update({
      where: { id: player.id },
      data: {
        honeyLatest: rankProfit.profit,
        balance: { increment: rankProfit.profit },
      },
    });

    await this.prismaService.playerRankProfit.update({
      where: { id: rankProfit.id },
      data: { isCollected: true },
    });

    await this.profitCommonService.writeProfit(
      player.id,
      rankProfit.profit,
      ProfitType.rank,
    );

    await this.profitCommonService.calculateProfit(
      player.id,
      rankProfit.profit,
    );

    return { message: 'Rank profit collected!' };
  }

  private async findPlayerById(playerId: string) {
    this.logger.log(`Поиск игрока с ID ${playerId}`);
    const player = await this.prismaService.players.findUnique({
      where: { id: playerId },
    });
    if (!player) {
      this.logger.error(`Игрок с ID ${playerId} не найден`);
      throw new NotFoundException('Player not found');
    }
    this.logger.log(`Игрок с ID ${playerId} успешно найден`);
    return player;
  }
}
