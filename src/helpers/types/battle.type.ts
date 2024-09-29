import { ApiProperty } from '@nestjs/swagger';

export class BattleType {
  @ApiProperty({
    description: 'Текущая серия побед над боссами',
    example: 5,
  })
  bossStreak: number;

  @ApiProperty({
    description: 'Обновленный баланс игрока после сражения',
    example: 1000,
  })
  newBalance: number;
}
