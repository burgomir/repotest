import { applyDecorators } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';

export function DeleteReferralQuestOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Delete a referral quest by ID' }),
    ApiOkResponse({ description: 'Referral quest deleted successfully' }),
    ApiBearerAuth(),
    ApiNotFoundResponse({ description: 'Referral quest not found' }),
  );
}
