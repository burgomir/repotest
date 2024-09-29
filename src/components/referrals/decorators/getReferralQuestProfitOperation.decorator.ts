import { applyDecorators } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiOperation } from '@nestjs/swagger';
import { Player } from 'src/common/decorators/isPlayer.decorator';

export function GetReferralQuestProfitOperation() {
  return applyDecorators(
    ApiOperation({
      summary: 'Get and credit referral quest rewards for player',
    }),
    ApiOkResponse({ description: 'Rewards credited successfully' }),
    ApiBearerAuth(),
    Player(),
  );
}
