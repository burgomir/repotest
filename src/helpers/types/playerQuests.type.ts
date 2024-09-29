import { ApiProperty } from '@nestjs/swagger';
import { PlayersQuests } from '@prisma/client';

export class PlayerQuests implements PlayersQuests {
  @ApiProperty({
    description: 'Unique identifier for the player quest',
    example: '123e4567-e89b-12d3-a456-426614174000',
  })
  id: string;

  @ApiProperty({
    description: 'Indicates whether the quest has been completed',
    example: true,
  })
  isCompleted: boolean;

  @ApiProperty({
    description: 'Timestamp when the quest was created',
    example: '2023-07-04T12:34:56Z',
  })
  createdAt: Date;

  @ApiProperty({
    description: 'Timestamp when the quest will completed',
    example: '2023-07-04T12:34:56Z',
  })
  completedAt: Date;

  @ApiProperty({
    description: 'Unique identifier for the quest',
    example: 'quest-001',
  })
  questId: string;

  @ApiProperty({
    description: 'Unique identifier for the player',
    example: 'player-001',
  })
  playerId: string;
}
