import { applyDecorators } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { Player } from 'src/common/decorators/isPlayer.decorator';

export function UpdatePlayerBalanceOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Update player balance' }),
    ApiNotFoundResponse({ description: 'Player not found' }),
    ApiOkResponse({ description: 'Player balance updated successfully' }),
    Player(),
    ApiBearerAuth(),
  );
}
