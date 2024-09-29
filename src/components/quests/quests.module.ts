import { Module } from '@nestjs/common';
import { QuestsService } from './quests.service';
import { QuestsController } from './quests.controller';
import { QuestProfitModule } from 'src/libs/bull/questProfit/questProfit.module';

@Module({
  imports: [QuestProfitModule],
  controllers: [QuestsController],
  providers: [QuestsService],
})
export class QuestsModule {}
