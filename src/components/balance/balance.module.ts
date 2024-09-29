import { Module } from '@nestjs/common';
import { BalanceService } from './balance.service';
import { BalanceController } from './balance.controller';
import { RedisModule } from 'src/libs/redis/redis.module';

@Module({
  imports: [RedisModule],
  controllers: [BalanceController],
  providers: [BalanceService],
  exports: [BalanceService],
})
export class BalanceModule {}
