import { ApiProperty } from '@nestjs/swagger';
import { $Enums } from '@prisma/client';
import { ReferralEarlyBonuses } from '../dto/referralEarlyBonuses.dto';

export class ReferralsEarlyBonusType implements ReferralEarlyBonuses {
  @ApiProperty({
    description: 'Type of the account associated with the referral bonus',
    enum: $Enums.AccountType,
    example: $Enums.AccountType.COMMON,
    required: false,
  })
  accountType?: $Enums.AccountType;

  @ApiProperty({
    description: 'Amount of honey earned as an early bonus',
    example: 500,
  })
  honey: number;
}
