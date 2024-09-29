import { ApiProperty } from '@nestjs/swagger';
import { $Enums, PlayerProgress } from '@prisma/client';

export class PlayerProgressType implements PlayerProgress {
  @ApiProperty({ description: 'Player progress id' })
  id: string;

  @ApiProperty({ description: 'Player  id' })
  playerId: string;

  @ApiProperty({ description: 'Player progress' })
  progress: number;

  @ApiProperty({
    description: 'Player progress type',
    enum: $Enums.progressType,
  })
  type: $Enums.progressType;
}
