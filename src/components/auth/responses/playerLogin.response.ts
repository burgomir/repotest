import { Type } from 'class-transformer';
import { ApiProperty, PickType } from '@nestjs/swagger';
import { SuccessResponse } from 'src/helpers/common/successResponse.type';
import { PlayersType } from 'src/helpers/types/players.type';

export class PlayerLoginResponse extends PickType(SuccessResponse, [
  'message',
  'accessToken',
  'refreshToken',
] as const) {
  @ApiProperty({ type: PlayersType })
  @Type(() => PlayersType)
  player: PlayersType;

  @ApiProperty({ type: Boolean, description: 'If user new' })
  isNew?: boolean;
}
