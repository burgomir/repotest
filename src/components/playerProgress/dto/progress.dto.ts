import { PickType } from '@nestjs/swagger';
import { PlayerProgressType } from 'src/helpers/types/playerProgress.type';

export class PlayerProgressDto extends PickType(PlayerProgressType, [
  'progress',
  'type',
] as const) {}
