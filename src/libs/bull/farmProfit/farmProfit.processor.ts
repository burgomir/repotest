import { Processor, Process } from '@nestjs/bull';
import { Job } from 'bull';
import { FarmProfitService } from './farmProfit.service';

@Processor('addFarmProfit')
export class FarmProfitProcessor {
  constructor(private farmProfitService: FarmProfitService) {}

  @Process('farmProfit')
  async handleFarmProfitJob(job: Job) {
    await this.farmProfitService.handleFarmProfitJob(job);
  }
}
