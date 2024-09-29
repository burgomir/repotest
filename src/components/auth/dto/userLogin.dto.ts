import { PickType } from '@nestjs/swagger';
import { PlayerDto } from 'src/helpers/dto/player.dto';

export class PlayerLoginDto extends PickType(PlayerDto, [
  'initData'
] as const) {}
