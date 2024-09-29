import { Module } from '@nestjs/common';
import { BullModule } from '@nestjs/bull';
import { ConfigService } from '@nestjs/config';
import { FarmProfitModule } from './farmProfit/farmProfit.module';
import { QuestsModule } from 'src/components/quests/quests.module';
@Module({
  imports: [
    BullModule.forRootAsync({
      inject: [ConfigService],
      useFactory: async (configService: ConfigService) => ({
        redis: {
          host: configService.get('REDIS_HOST'),
          port: configService.get<number>('REDIS_PORT'),
        },
      }),
    }),
    FarmProfitModule,
    QuestsModule,
  ],
  providers: [],
})
export class BullQueuesModule {}
