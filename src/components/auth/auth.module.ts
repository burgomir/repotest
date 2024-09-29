import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { TokenModule } from '../token/token.module';
import { ReferralsModule } from '../referrals/referrals.module';
import { ProfitCommonModule } from '../profitCommon/profitCommon.module';

@Module({
  imports: [TokenModule, ReferralsModule, ProfitCommonModule],
  controllers: [AuthController],
  providers: [AuthService],
})
export class AuthModule {}
