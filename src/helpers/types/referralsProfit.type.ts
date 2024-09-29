import { ApiProperty } from '@nestjs/swagger';
import { ReferralsProfit } from '@prisma/client';

export class ReferralsProfitType implements ReferralsProfit {
  @ApiProperty({
    description: 'Unique identifier for the referrals profit entry',
    example: '123e4567-e89b-12d3-a456-426614174006',
  })
  id: string;

  @ApiProperty({
    description: 'Amount of honey earned from referrals',
    example: 1500,
  })
  honey: number;

  @ApiProperty({
    description: 'Unique identifier for the player',
    example: 'player-005',
  })
  playerId: string;
}
