import { Module } from '@nestjs/common';
import { PlayerCommonService } from './playerCommon.service';

@Module({
  providers: [PlayerCommonService],
})
export class PlayerCommonModule {}
