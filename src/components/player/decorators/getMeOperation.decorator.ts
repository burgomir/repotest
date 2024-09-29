import { applyDecorators, UseInterceptors } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { Player } from 'src/common/decorators/isPlayer.decorator';
import { TransformDataInterceptor } from 'src/common/interceptors/transformData.interceptor';
import { PlayersType } from 'src/helpers/types/players.type';

export function GetMeOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Get current player' }),
    ApiNotFoundResponse({ description: 'Player not found' }),
    ApiOkResponse({
      description: 'Current player returned successfully',
      type: PlayersType,
    }),
    UseInterceptors(new TransformDataInterceptor(PlayersType)),
    Player(),
    ApiBearerAuth(),
  );
}
