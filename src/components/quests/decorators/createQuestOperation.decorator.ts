import { applyDecorators } from '@nestjs/common';
import { ApiCreatedResponse, ApiOperation } from '@nestjs/swagger';
import { CreateQuestsResponse } from '../responses/createQuests.response';

export function CreateQuestOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Create a new quest' }),
    ApiCreatedResponse({
      description: 'Quest created successfully',
      type: CreateQuestsResponse,
    }),
  );
}
