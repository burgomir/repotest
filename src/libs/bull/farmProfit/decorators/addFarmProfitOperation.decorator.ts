import { applyDecorators, HttpCode } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';

export function AddFarmProfitOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Passive honey farming' }),
    ApiOkResponse({
      description: 'Task to farm is in queue',
    }),
    HttpCode(200),
    ApiNotFoundResponse({ description: 'Player not found!' }),
  );
}
