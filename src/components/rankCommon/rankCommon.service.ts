import { Injectable, Logger } from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { NotificationGateway } from '../socket/gateways/notification.gateway';
import { progressType } from '@prisma/client';

@Injectable()
export class RankCommonService {
  constructor(
    private prismaService: PrismaService,
    private notificationGateWay: NotificationGateway,
  ) {}
  private logger = new Logger(RankCommonService.name);

  async checkRankUpdate(playerId: string) {
    this.logger.log(
      `Начало проверки обновления рангов для игрока с ID ${playerId}`,
    );

    const progress = await this.prismaService.playerProgress.findFirst({
      where: { playerId, type: progressType.Rank },
    });

    if (!progress) {
      await this.prismaService.playerProgress.create({
        data: { type: progressType.Rank, playerId, progress: 0 },
      });
    }

    try {
      const player = await this.prismaService.players.findUnique({
        where: { id: playerId },
        include: {
          playerProgress: true,
          playerRanks: {
            include: {
              rank: true,
            },
          },
        },
      });

      if (!player) {
        this.logger.log(`Игрок с ID ${playerId} не найден`);
        return;
      }

      const ranks = await this.prismaService.ranks.findMany({
        orderBy: { rank: 'asc' },
      });

      const playerProgress = player.playerProgress.find(
        (progress) => progress.type === 'Rank',
      );

      if (playerProgress) {
        let remainingProgress = playerProgress.progress;
        const achievableRanks = ranks.filter(
          (rank) => remainingProgress >= rank.requiredAmount,
        );

        for (const rank of achievableRanks) {
          const hasAchievedRank = player.playerRanks.some(
            (playerRank) => playerRank.rank.id === rank.id,
          );

          if (!hasAchievedRank) {
            remainingProgress -= rank.requiredAmount;

            if (remainingProgress < 0) {
              this.logger.error(
                `Ошибка: отрицательный прогресс у игрока с ID ${player.id}. Остаток прогресса: ${remainingProgress}`,
              );
              remainingProgress += rank.requiredAmount;
              continue;
            }

            // Создаем запись для нового ранга
            await this.prismaService.playerRankProfit.create({
              data: {
                playerId: player.id,
                rankId: rank.id,
                profit: rank.bonusAmount,
                isCollected: false, // Устанавливаем как false для новых рангов
              },
            });

            await this.prismaService.playerRanks.create({
              data: {
                achievedAt: new Date(Date.now()),
                playerId: player.id,
                rankId: rank.id,
              },
            });

            this.logger.log(
              `Игроку с ID ${player.id} был обновлен ранг до ${rank.name}, добавлена запись в PlayerRankProfit. Остаток прогресса: ${remainingProgress}`,
            );
            await this.notificationGateWay.sendRankLevelUpNotification(
              player.id,
              'You have level upped rank',
              rank.rank,
              rank.bonusAmount,
            );
          } else {
            this.logger.log(
              `Игрок с ID ${player.id} уже имеет ранг ${rank.name}`,
            );
          }
        }

        // Проверяем и обновляем ранг 0, если игрок поднялся с ранга 0
        const zeroRank = ranks.find((rank) => rank.rank === 0);
        if (zeroRank) {
          const zeroRankProfit =
            await this.prismaService.playerRankProfit.findFirst({
              where: { playerId: player.id, rankId: zeroRank.id },
            });

          if (!zeroRankProfit) {
            await this.prismaService.playerRankProfit.create({
              data: {
                playerId: player.id,
                rankId: zeroRank.id,
                profit: zeroRank.bonusAmount,
                isCollected: true, // Устанавливаем как true для ранга 0
              },
            });
            this.logger.log(
              `Создана запись в PlayerRankProfit для ранга 0 и игрока ${player.id}`,
            );
          } else if (!zeroRankProfit.isCollected) {
            // Если запись есть, но isCollected не установлен в true
            await this.prismaService.playerRankProfit.update({
              where: { id: zeroRankProfit.id },
              data: { isCollected: true },
            });
            this.logger.log(
              `Обновлена запись в PlayerRankProfit для ранга 0 и игрока ${player.id}`,
            );
          }
        }

        console.log(
          '🚀 ~ RankCommonService ~ checkRankUpdate ~ remainingProgress:',
          remainingProgress,
        );

        await this.prismaService.playerProgress.update({
          where: { id: playerProgress.id },
          data: { progress: remainingProgress },
        });

        this.logger.log(
          `Обновлен прогресс игрока с ID ${player.id}. Остаток прогресса: ${remainingProgress}`,
        );
      } else {
        this.logger.log(
          `Игрок с ID ${player.id} не имеет прогресса для типа 'Rank'`,
        );
      }

      this.logger.log('Проверка и обновление рангов завершена успешно');
    } catch (error) {
      this.logger.error('Ошибка при проверке и обновлении рангов', error);
    }
  }
}
