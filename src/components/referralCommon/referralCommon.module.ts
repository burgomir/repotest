import { Module } from '@nestjs/common';
import { ReferralCommonService } from './referralCommon.service';
import { PlayerProgressModule } from '../playerProgress/playerProgress.module';

@Module({
  imports: [PlayerProgressModule],
  providers: [ReferralCommonService],
  exports: [ReferralCommonService],
})
export class ReferralCommonModule {}
