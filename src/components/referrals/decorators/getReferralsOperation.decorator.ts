import { applyDecorators, UseInterceptors } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { Player } from 'src/common/decorators/isPlayer.decorator';
import { GetReferralsResponse } from '../responses/getReferrals.response';
import { TransformDataInterceptor } from 'src/common/interceptors/transformData.interceptor';

export function GetReferralsOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Get referrals' }),
    ApiOkResponse({
      description: 'List of referrals.',
      type: GetReferralsResponse,
    }),
    UseInterceptors(new TransformDataInterceptor(GetReferralsResponse)),
    ApiNotFoundResponse({ description: 'Player not found.' }),
    ApiBearerAuth(),
    Player(),
  );
}
