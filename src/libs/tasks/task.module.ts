import { Module } from '@nestjs/common';
import { TasksService } from './task.service';
import { ScheduleModule } from '@nestjs/schedule';
import { BalanceModule } from 'src/components/balance/balance.module';
import { PlayerModule } from 'src/components/player/player.module';
import { TelegramModule } from 'src/utils/telegram/telegram.module';
import { RewardModule } from '../reward/reward.module';


@Module({
  imports: [ScheduleModule.forRoot(), BalanceModule, PlayerModule, TelegramModule, RewardModule],
  providers: [TasksService],
})
export class TasksModule {}
