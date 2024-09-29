import { ApiProperty } from '@nestjs/swagger';
import { PlayerRanks } from '@prisma/client';

export class PlayerRanksType implements PlayerRanks {
  @ApiProperty({
    description: 'Unique identifier for the player rank',
    example: '123e4567-e89b-12d3-a456-426614174002',
  })
  id: string;

  @ApiProperty({
    description: 'Timestamp when the rank was achieved',
    example: '2023-07-04T12:34:56Z',
  })
  achievedAt: Date;

  @ApiProperty({
    description: 'Unique identifier for the player',
    example: 'player-003',
  })
  playerId: string;

  @ApiProperty({
    description: 'Unique identifier for the rank',
    example: 'rank-003',
  })
  rankId: string;
}
