import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { CreateReferralEarlyBonusDto } from '../referrals/dto/createReferralEarlyBonus.dto';
import { PlayerProgressService } from '../playerProgress/playerProgress.service';

@Injectable()
export class ReferralCommonService {
  private logger = new Logger(ReferralCommonService.name);
  constructor(private prismaService: PrismaService) {}

  async calculateReferralProfit(
    dto: CreateReferralEarlyBonusDto,
    playerId: string,
  ) {
    const player = await this.findPlayerById(playerId);

    const profit = dto.honey * 0.05;

    await this.prismaService.referralsEarlyBonuses.create({
      data: { playerId: player.id, honey: profit },
    });

    const referralProfit = await this.prismaService.referralsProfit.findUnique({
      where: { playerId: player.id },
    });
    if (!referralProfit) {
      await this.prismaService.referralsProfit.create({
        data: { playerId: player.id, honey: profit },
      });

      this.logger.log(`Добавлена прибыль от реферала для ID: ${player.id}`);
      return { message: 'Прибыль от реферала добавлена' };
    }
    await this.prismaService.referralsProfit.update({
      where: { playerId: player.id },
      data: { honey: { increment: profit } },
    });

    this.logger.log(`Добавлена прибыль от реферала для ID: ${player.id}`);
    return { message: 'Прибыль от реферала добавлена' };
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
