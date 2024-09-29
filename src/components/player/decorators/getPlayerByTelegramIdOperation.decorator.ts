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

export function GetPlayerByTelegramIdOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Get player by Telegram ID' }),
    ApiOkResponse({
      type: PlayersType,
      description: 'Player returned by id successfully!',
    }),
    ApiNotFoundResponse({ description: 'Player not found!' }),
    UseInterceptors(new TransformDataInterceptor(PlayersType)),
    Player(),
    ApiBearerAuth(),
  );
}
