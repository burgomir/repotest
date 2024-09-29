import { applyDecorators } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { SuccessMessageType } from 'src/helpers/common/successMessage.type';

export function DeleteQuestOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Delete a quest by ID' }),
    ApiOkResponse({
      description: 'Quest deleted successfully',
      type: SuccessMessageType,
    }),
    ApiNotFoundResponse({ description: 'Quest not found' }),
  );
}
