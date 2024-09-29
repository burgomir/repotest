import { Processor, Process } from '@nestjs/bull';
import { Job } from 'bull';
import { QuestProfitService } from './questProfit.service';

@Processor('completeQuest')
export class QuestProfitProcessor {
  constructor(private readonly questProfitService: QuestProfitService) {}

  @Process('completeQuest')
  async handleCompleteQuestJob(job: Job) {
    await this.questProfitService.handleCompleteQuestJob(job);
  }
}
