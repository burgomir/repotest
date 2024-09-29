import { PickType } from '@nestjs/swagger';
import { PlayerOrcType } from '../types/playerOrc.type';
import { IsNotEmpty, IsNumber, IsOptional } from 'class-validator';

export class PlayerOrcDto extends PickType(PlayerOrcType, [
  'bossStreak',
  'hp',
]) {
  @IsNumber()
  @IsOptional()
  bossStreak?: number;

  @IsNumber()
  @IsNotEmpty()
  hp: number;
}
