import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectQueue } from '@nestjs/bull';
import { Queue } from 'bull';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { ConfigService } from '@nestjs/config';
import { CreateReferralEarlyBonusDto } from 'src/components/referrals/dto/createReferralEarlyBonus.dto';
import { ReferralCommonService } from 'src/components/referralCommon/referralCommon.service';

@Injectable()
export class FarmProfitService {
  constructor(
    @InjectQueue('addFarmProfit')
    private readonly farmProfitQueue: Queue,
    private readonly prismaService: PrismaService,
    private configService: ConfigService,
    private referralCommonService: ReferralCommonService,
  ) {}

  async addFarmProfitToBalance(playerId: string) {
    const now = new Date();
    const player = await this.prismaService.players.findUnique({
      where: { id: playerId },
    });
    if (player.farmingDate) {
      const now = new Date();
      if (
        now.getTime() - new Date(player.farmingDate).getTime() <
        this.configService.get<number>('FARMING_INTERVAL')
      )
        throw new ForbiddenException(
          'Cannot farm again yet. Wait for 1 minute.',
        );
    }
    await this.farmProfitQueue.add(
      'farmProfit',
      { playerId },
      {
        delay: this.configService.get<number>('FARMING_INTERVAL'),
        removeOnComplete: true,
        backoff: {
          type: 'fixed',
          delay: 5000,
        },
      },
    );

    await this.prismaService.players.update({
      where: { id: playerId },
      data: { farmingDate: now },
    });
  }

  async handleFarmProfitJob(job) {
    const { playerId } = job.data;

    const player = await this.prismaService.players.findUnique({
      where: { id: playerId },
    });

    if (!player) {
      throw new NotFoundException('Player not found');
    }

    const bonusAmount = player.balance * 0.005;

    await this.prismaService.players.update({
      where: { id: playerId },
      data: {
        balance: { increment: bonusAmount },
        farmingDate: new Date(Date.now()),
      },
    });

    const referralDto: CreateReferralEarlyBonusDto = {
      honey: bonusAmount,
    };

    await this.referralCommonService.calculateReferralProfit(
      referralDto,
      player.referredById,
    );

    return {
      ...player,
      balance: player.balance + bonusAmount,
    };
  }
}
