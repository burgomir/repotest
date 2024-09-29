import { ApiProperty, PickType } from '@nestjs/swagger';
import { ReferralsEarlyBonusType } from '../types/referralsEarlyBonus.type';
import { IsEnum, IsNotEmpty, IsNumber, IsOptional } from 'class-validator';
import { AccountType } from '@prisma/client';

export class ReferralEarlyBonuses extends PickType(ReferralsEarlyBonusType, [
  'honey',
] as const) {
  @IsOptional()
  @IsEnum(AccountType)
  @ApiProperty({ enum: AccountType, description: 'Account type' })
  accountType?: AccountType;

  @IsNotEmpty()
  @IsNumber()
  honey: number;
}
