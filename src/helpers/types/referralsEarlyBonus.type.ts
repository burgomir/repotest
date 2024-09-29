import { AccountType, ReferralsEarlyBonuses } from '@prisma/client';
import { ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';

export class ReferralsEarlyBonusType implements ReferralsEarlyBonuses {
  @ApiProperty({
    description: 'Unique identifier for the early bonus referral',
    example: '123e4567-e89b-12d3-a456-426614174000',
  })
  id: string;

  @ApiProperty({
    description: 'Amount of honey awarded',
    example: 100.5,
  })
  honey: number;

  @ApiProperty({
    description: 'Multiplier applied to the bonus',
    example: 1.5,
  })
  multiplier: number;

  @Exclude()
  playerId: string;

  @ApiProperty({
    description: 'Premium bonus value',
    type: AccountType,
    required: false,
  })
  accountType: AccountType;
}
