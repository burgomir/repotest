import { MiddlewareConsumer, Module, OnModuleInit } from '@nestjs/common';
import { APP_FILTER, APP_GUARD, APP_INTERCEPTOR } from '@nestjs/core';
import { AllExceptionsFilter } from './utils/core/allException.filter';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TerminusModule } from '@nestjs/terminus';
import { MinioModule } from './libs/minio/minio.module';
import { validate } from './config/env.validation';
import { CacheInterceptor, CacheModule } from '@nestjs/cache-manager';
import { RedisClientOptions } from 'redis';
import { PrismaModule } from './utils/prisma/prisma.module';
import { TimeoutInterceptor } from './common/interceptors/timeout.interceptor';
import { TokenModule } from './components/token/token.module';
import { ExcludeNullInterceptor } from './common/interceptors/excludeNulls.interceptor';
import { HealthModule } from './utils/health/health.module';
import { LoggerModule } from './libs/logger/logger.module';
import { LogsMiddleware } from './libs/logger/middleware/logs.middleware';
import { MediaModule } from './libs/media/media.module';
import { AuthModule } from './components/auth/auth.module';
import { PlayerModule } from './components/player/player.module';
import { AuthGuard } from './common/guards/auth.guard';
import { QuestsModule } from './components/quests/quests.module';
import { ReferralsModule } from './components/referrals/referrals.module';
import { TasksModule } from './libs/tasks/task.module';
import { BullQueuesModule } from './libs/bull/bull.module';
import { FarmProfitModule } from './libs/bull/farmProfit/farmProfit.module';
import { RankModule } from './components/rank/rank.module';
import { OrcModule } from './components/orc/orc.module';
import { PlayerProgressModule } from './components/playerProgress/playerProgress.module';
import { QuestProfitModule } from './libs/bull/questProfit/questProfit.module';
import { RankCommonModule } from './components/rankCommon/rankCommon.module';
import { ReferralCommonModule } from './components/referralCommon/referralCommon.module';
import { PlayerCommonModule } from './components/playerCommon/playerCommon.module';
import { ProfitCommonModule } from './components/profitCommon/profitCommon.module';
import { SocketModule } from './components/socket/socket.module';
import { BalanceModule } from './components/balance/balance.module';
import { RedisModule } from './libs/redis/redis.module';
import { MongooseModule } from '@nestjs/mongoose';
import { CiphersModule } from './components/cipher/ciphers.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: `.${process.env.NODE_ENV}.env`,
      // validate,
      isGlobal: true,
      cache: true,
    }),
    CacheModule.registerAsync<RedisClientOptions>({
      inject: [ConfigService],
      useFactory: async (configService: ConfigService) => ({
        store: 'redis',
        ttl: 60,
        host: configService.getOrThrow<string>('REDIS_HOST'),
        port: configService.getOrThrow<number>('REDIS_PORT'),
        no_ready_check: true,
      }),
    }),
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (configService: ConfigService) => {
        const username = configService.get('MONGO_USERNAME');
        const password = configService.get('MONGO_PASSWORD');
        const database = configService.get('MONGO_DATABASE');
        const host = configService.get('MONGO_HOST');

        return {
          uri: `mongodb://${username}:${password}@${host}`,
          dbName: database,
        };
      },
      inject: [ConfigService],
    }),
    TerminusModule.forRoot(),
    LoggerModule,
    HealthModule,
    MediaModule,
    MinioModule,
    PrismaModule,
    TokenModule,
    AuthModule,
    PlayerModule,
    ReferralsModule,
    QuestsModule,
    TasksModule,
    BullQueuesModule,
    FarmProfitModule,
    RankModule,
    OrcModule,
    PlayerProgressModule,
    CiphersModule,
    QuestProfitModule,
    PlayerCommonModule,
    RankCommonModule,
    ReferralCommonModule,
    ProfitCommonModule,
    SocketModule,
    BalanceModule,
    RedisModule,
  ],
  providers: [
    {
      provide: APP_FILTER,
      useClass: AllExceptionsFilter,
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: TimeoutInterceptor,
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: ExcludeNullInterceptor,
    },
    {
      provide: APP_GUARD,
      useClass: AuthGuard,
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: CacheInterceptor,
    },
  ],
})
export class AppModule implements OnModuleInit {
  constructor() {}
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(LogsMiddleware).forRoutes('*');
  }
  async onModuleInit() {}
}
