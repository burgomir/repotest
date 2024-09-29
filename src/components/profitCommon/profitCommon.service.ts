import { Injectable } from '@nestjs/common';
import { ReferralCommonService } from '../referralCommon/referralCommon.service';
import { RankCommonService } from '../rankCommon/rankCommon.service';
import { PlayerProgressDto } from '../playerProgress/dto/progress.dto';
import { $Enums, ProfitType } from '@prisma/client';
import { PlayerProgressService } from '../playerProgress/playerProgress.service';
import { CreateReferralEarlyBonusDto } from '../referrals/dto/createReferralEarlyBonus.dto';
import { PrismaService } from 'src/utils/prisma/prisma.service';

@Injectable()
export class ProfitCommonService {
  constructor(
    private referralCommonService: ReferralCommonService,
    private rankCommonService: RankCommonService,
    private playerProgressService: PlayerProgressService,
    private prismaService: PrismaService,
  ) {}

  async calculateProfit(playerId: string, honey: number) {
    console.log('🚀 ~ ProfitCommonService ~ calculateProfit ~ honey:', honey);
    const player = await this.prismaService.players.findUnique({
      where: { id: playerId },
    });
    if (honey === 0) return;
    const playerProgressDto: PlayerProgressDto = {
      progress: honey,
      type: $Enums.progressType.Rank,
    };

    await this.playerProgressService.createProgressOrUpdate(
      playerProgressDto,
      player.id,
    );
    if (!player.referredById) {
      await this.rankCommonService.checkRankUpdate(player.id);
      return;
    }
    const referralDto: CreateReferralEarlyBonusDto = {
      honey: honey,
    };
    await this.referralCommonService.calculateReferralProfit(
      referralDto,
      player.referredById,
    );
    await this.rankCommonService.checkRankUpdate(player.id);
  }

  async writeProfit(playerId: string, profit: number, profitType: ProfitType) {
    await this.prismaService.profit.create({
      data: { profit, playerId, profitType },
    });
  }
}
