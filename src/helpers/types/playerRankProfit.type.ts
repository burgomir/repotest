import { ApiProperty } from '@nestjs/swagger';
import { PlayerRankProfit } from '@prisma/client';

export class PlayerRankProfitType implements PlayerRankProfit {
  @ApiProperty({
    description: 'Unique identifier for the player rank profit',
    example: '123e4567-e89b-12d3-a456-426614174001',
  })
  id: string;

  @ApiProperty({
    description: 'Indicates whether the profit has been collected',
    example: true,
  })
  isCollected: boolean;

  @ApiProperty({
    description: 'Amount of profit earned',
    example: 1000,
  })
  profit: number;

  @ApiProperty({
    description: 'Unique identifier for the player',
    example: 'player-002',
  })
  playerId: string;

  @ApiProperty({
    description: 'Unique identifier for the rank',
    example: 'rank-002',
  })
  rankId: string;
}
