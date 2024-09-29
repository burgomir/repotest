import { applyDecorators, UseInterceptors } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiOperation } from '@nestjs/swagger';
import { Player } from 'src/common/decorators/isPlayer.decorator';
import { TransformDataInterceptor } from 'src/common/interceptors/transformData.interceptor';
import { QuestsWithCompletion } from 'src/helpers/types/quests.type';

export function GetPlayerQuestsOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Get quests of the current player' }),
    ApiOkResponse({
      description: 'List of player quests with completion status',
      type: [QuestsWithCompletion],
    }),
    UseInterceptors(new TransformDataInterceptor(QuestsWithCompletion)),
    Player(),
    ApiBearerAuth(),
  );
}
