import { applyDecorators } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';

export function GetRankByIdOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Get rank by ID' }),
    ApiOkResponse({ description: 'Get rank by id' }),
    ApiNotFoundResponse({ description: 'Rank not found' }),
  );
}
