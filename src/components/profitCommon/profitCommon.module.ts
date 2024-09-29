import { Module } from '@nestjs/common';
import { ProfitCommonService } from './profitCommon.service';
import { ReferralCommonModule } from '../referralCommon/referralCommon.module';
import { RankCommonModule } from '../rankCommon/rankCommon.module';
import { PlayerProgressModule } from '../playerProgress/playerProgress.module';

@Module({
  imports: [ReferralCommonModule, RankCommonModule, PlayerProgressModule],
  providers: [ProfitCommonService],
  exports: [ProfitCommonService],
})
export class ProfitCommonModule {}
