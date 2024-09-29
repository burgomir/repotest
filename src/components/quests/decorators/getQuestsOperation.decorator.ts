import { applyDecorators } from '@nestjs/common';
import { ApiOkResponse, ApiOperation } from '@nestjs/swagger';
import { GetQuestsResponse } from '../responses/getQuests.response';

export function GetQuestsOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Get all quests' }),
    ApiOkResponse({ description: 'List of quests', type: GetQuestsResponse }),
  );
}
