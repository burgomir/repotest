import { Module } from '@nestjs/common';
import { ReferralsService } from './referrals.service';
import { ReferralsController } from './referrals.controller';
import { ProfitCommonModule } from '../profitCommon/profitCommon.module';
import { PlayerProgressModule } from '../playerProgress/playerProgress.module';

@Module({
  imports: [ProfitCommonModule, PlayerProgressModule],
  controllers: [ReferralsController],
  providers: [ReferralsService],
  exports: [ReferralsService],
})
export class ReferralsModule {}
