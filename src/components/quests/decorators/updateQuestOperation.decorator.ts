import { applyDecorators } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { UpdateQuestsResponse } from '../responses/updateQuests.response';

export function UpdateQuestOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Update a quest by ID' }),
    ApiOkResponse({
      description: 'Quest updated successfully',
      type: UpdateQuestsResponse,
    }),
    ApiNotFoundResponse({ description: 'Quest not found' }),
  );
}
