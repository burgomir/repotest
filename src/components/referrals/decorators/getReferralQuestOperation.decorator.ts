import { applyDecorators } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { Player } from 'src/common/decorators/isPlayer.decorator';
import { GetReferralQuestsResponse } from '../responses/getReferralQuests.response';

export function GetReferralQuestOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Get a referral quest by ID' }),
    ApiOkResponse({
      description: 'Referral quest details',
      type: GetReferralQuestsResponse,
    }),
    ApiNotFoundResponse({ description: 'Referral quest not found' }),
    Player(),
    ApiBearerAuth(),
  );
}
