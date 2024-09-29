import { applyDecorators } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { Player } from 'src/common/decorators/isPlayer.decorator';

export function CollectReferralProfitOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Collect referral profit' }),
    ApiOkResponse({ description: 'Referral profit collected.' }),
    ApiNotFoundResponse({
      description: 'Player or referral profit not found.',
    }),
    ApiBearerAuth(),
    Player(),
  );
}
