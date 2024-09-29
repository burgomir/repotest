import { Module } from '@nestjs/common';
import { PlayerProgressService } from './playerProgress.service';

@Module({
  providers: [PlayerProgressService],
  exports: [PlayerProgressService],
})
export class PlayerProgressModule {}
