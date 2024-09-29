import { applyDecorators } from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { Player } from 'src/common/decorators/isPlayer.decorator';
import { SuccessMessageType } from 'src/helpers/common/successMessage.type';

export function CompleteQuestOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Complete a quest for the current player' }),
    ApiCreatedResponse({
      description: 'Quest completed successfully',
      type: SuccessMessageType,
    }),
    ApiBadRequestResponse({ description: 'Invalid quest ID or player ID' }),
    Player(),
    ApiBearerAuth(),
  );
}
