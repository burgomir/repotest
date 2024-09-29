import { applyDecorators } from '@nestjs/common';
import {
  ApiBody,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { UpdateRankDto } from '../dto/updateRank.dto';

export function UpdateRankOperation() {
  return applyDecorators(
    ApiOkResponse({ description: 'Updated' }),
    ApiOperation({ summary: 'Update an existing rank' }),
    ApiNotFoundResponse({ description: 'Rank not found' }),
    ApiBody({ type: UpdateRankDto }),
  );
}
