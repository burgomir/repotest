import { ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';

export class PlayerOrcType {
  @ApiProperty({
    description: 'Уникальный идентификатор записи',
    example: '123e4567-e89b-12d3-a456-426614174000',
  })
  id: string;

  @Exclude()
  orcId: string;

  @Exclude()
  playerId: string;

  @ApiProperty({
    description: 'Количество здоровья орка',
    example: 100,
  })
  hp: number;

  @ApiProperty({
    description: 'Текущая серия побед над боссами',
    example: 5,
  })
  bossStreak?: number;

  @ApiProperty({
    description: 'Дата последней победы над боссом',
    example: '2023-12-31T12:00:00Z',
  })
  lastBossDate: Date;
}
