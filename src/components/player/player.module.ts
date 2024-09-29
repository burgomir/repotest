import { Module } from '@nestjs/common';
import { PlayerService } from './player.service';
import { PlayerController } from './player.controller';
import { OrcModule } from '../orc/orc.module';
import { PlayerProgressModule } from '../playerProgress/playerProgress.module';
import { ReferralCommonModule } from '../referralCommon/referralCommon.module';
import { RankCommonModule } from '../rankCommon/rankCommon.module';
import { ProfitCommonModule } from '../profitCommon/profitCommon.module';
import { TokenModule } from '../token/token.module';
import { SocketModule } from '../socket/socket.module';
import { BalanceModule } from '../balance/balance.module';
import { RewardModule } from '../../libs/reward/reward.module';
import { TelegramModule } from 'src/utils/telegram/telegram.module';

@Module({
  imports: [
    OrcModule,
    TokenModule,
    SocketModule,
    RewardModule,
    BalanceModule,
    TelegramModule,
    RankCommonModule,
    ProfitCommonModule,
    ReferralCommonModule,
    PlayerProgressModule,
  ],
  controllers: [PlayerController],
  providers: [PlayerService],
  exports: [PlayerService],
})
export class PlayerModule {}
