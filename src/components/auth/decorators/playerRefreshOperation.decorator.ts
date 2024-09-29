import { applyDecorators, UseInterceptors } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { TransformDataInterceptor } from 'src/common/interceptors/transformData.interceptor';
import { SetCookieInterceptor } from 'src/common/interceptors/setCookie.interceptor';
import { PlayerRefreshResponse } from '../responses/playerRefresh.response';

export function PlayerRefreshOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Refresh tokens' }),
    ApiBearerAuth(),
    ApiOkResponse({
      description: 'User tokens refreshed successfully.',
      type: PlayerRefreshResponse,
    }),
    ApiUnauthorizedResponse({ description: 'Refresh token not provided!' }),
    ApiUnauthorizedResponse({ description: 'Invalid token!' }),
    ApiNotFoundResponse({ description: 'User not found!' }),
    UseInterceptors(
      SetCookieInterceptor,
      new TransformDataInterceptor(PlayerRefreshResponse),
    ),
  );
}
