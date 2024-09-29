import { Type } from 'class-transformer';
import { SuccessResponse } from 'src/helpers/common/successResponse.type';
import { ApiProperty, PickType } from '@nestjs/swagger';
import { PlayersType } from 'src/helpers/types/players.type';

export class PlayerRefreshResponse extends PickType(SuccessResponse, [
  'message',
  'accessToken',
  'refreshToken',
] as const) {
  @ApiProperty({ type: PlayersType })
  @Type(() => PlayersType)
  player: PlayersType;
}
