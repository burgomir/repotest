import { Module } from '@nestjs/common';
import { RankCommonService } from './rankCommon.service';
import { PlayerProgressModule } from '../playerProgress/playerProgress.module';
import { SocketModule } from '../socket/socket.module';

@Module({
  imports: [PlayerProgressModule, SocketModule],
  providers: [RankCommonService],
  exports: [RankCommonService],
})
export class RankCommonModule {}
