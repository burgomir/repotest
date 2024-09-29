import { applyDecorators } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';

export function UpdateReferralQuestOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Update a referral quest by ID' }),
    ApiOkResponse({ description: 'Referral quest updated successfully' }),
    ApiBearerAuth(),
    ApiNotFoundResponse({ description: 'Referral quest not found' }),
  );
}
