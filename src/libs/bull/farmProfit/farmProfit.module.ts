import { Module } from '@nestjs/common';
import { BullModule } from '@nestjs/bull';
import { FarmProfitProcessor } from './farmProfit.processor';
import { FarmProfitService } from './farmProfit.service';
import { FarmProfitController } from './farmProfit.controller';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { PlayerModule } from 'src/components/player/player.module';
import { ReferralCommonModule } from 'src/components/referralCommon/referralCommon.module';

@Module({
  imports: [
    BullModule.registerQueue({
      name: 'addFarmProfit',
    }),
    ReferralCommonModule,
    PlayerModule,
  ],
  providers: [FarmProfitService, FarmProfitProcessor, PrismaService],
  controllers: [FarmProfitController],
})
export class FarmProfitModule {}
