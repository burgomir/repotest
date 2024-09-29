import { applyDecorators } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOperation,
} from '@nestjs/swagger';

export function CreateReferralQuestOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Create a new referral quest' }),
    ApiCreatedResponse({ description: 'Referral quest created successfully' }),
    ApiBearerAuth(),
  );
}
