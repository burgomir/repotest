import { ApiProperty, PickType } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber } from 'class-validator';
import { PlayerDto } from 'src/helpers/dto/player.dto';

export class UpdateBalanceDto extends PickType(PlayerDto, [
  'honeyLatest',
] as const) {
  @IsNotEmpty()
  @IsNumber()
  @ApiProperty({ type: Number, description: 'Earned honey' })
  honey: number;
}
