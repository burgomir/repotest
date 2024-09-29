import { Module } from '@nestjs/common';
import { QuestProfitService } from './questProfit.service';
import { BullModule } from '@nestjs/bull';
import { QuestProfitProcessor } from './quests.processor';
import { ProfitCommonModule } from 'src/components/profitCommon/profitCommon.module';
import { TelegramModule } from 'src/utils/telegram/telegram.module';

@Module({
  imports: [
    BullModule.registerQueue({
      name: 'completeQuest',
    }),
    ProfitCommonModule,
    TelegramModule
  ],
  providers: [QuestProfitService, QuestProfitProcessor],
  exports: [QuestProfitService, QuestProfitProcessor],
})
export class QuestProfitModule {}
