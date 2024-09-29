import { Module } from '@nestjs/common';
import { RanksService } from './rank.service';
import { RanksController } from './rank.controller';
import { ProfitCommonModule } from '../profitCommon/profitCommon.module';

@Module({
  imports: [ProfitCommonModule],
  controllers: [RanksController],
  providers: [RanksService],
})
export class RankModule {}
