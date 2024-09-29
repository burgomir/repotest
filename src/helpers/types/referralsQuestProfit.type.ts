import { ApiProperty } from '@nestjs/swagger';
import { ReferralsQuestProfit } from '@prisma/client';

export class ReferralsQuestProfitType implements ReferralsQuestProfit {
  @ApiProperty({
    description: 'Unique identifier for the referrals quest profit entry',
    example: '123e4567-e89b-12d3-a456-426614174003',
  })
  id: string;

  @ApiProperty({
    description: 'Unique identifier for the player',
    example: 'player-004',
  })
  playerId: string;

  @ApiProperty({
    description: 'Indicates whether the reward has been claimed',
    example: true,
  })
  claimed: boolean;

  @ApiProperty({
    description: 'Number of referrals counted towards the quest',
    example: 10,
  })
  referralCount: number;

  @ApiProperty({
    description: 'Unique identifier for the referrals quest',
    example: 'referrals-quest-001',
  })
  referralsQuestId: string;

  @ApiProperty({
    description: 'Amount of reward earned from the quest',
    example: 1000,
  })
  reward: number;
}
