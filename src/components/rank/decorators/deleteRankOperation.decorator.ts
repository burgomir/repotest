import { applyDecorators } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';

export function DeleteRankOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Delete a rank by ID' }),
    ApiOkResponse({
      description: 'Rank deleted successfully!',
    }),
    ApiNotFoundResponse({ description: 'Rank not found' }),
  );
}
