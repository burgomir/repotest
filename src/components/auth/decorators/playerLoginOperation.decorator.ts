import { applyDecorators, UseInterceptors } from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiBody,
  ApiNotFoundResponse,
  ApiOperation,
  ApiQuery,
  ApiResponse,
} from '@nestjs/swagger';
import { SetCookieInterceptor } from 'src/common/interceptors/setCookie.interceptor';
import { TransformDataInterceptor } from 'src/common/interceptors/transformData.interceptor';
import { PlayerLoginResponse } from '../responses/playerLogin.response';
import { PlayerLoginDto } from '../dto/userLogin.dto';

export function PlayerLoginOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'User login' }),
    ApiBody({ type: PlayerLoginDto }),
    ApiResponse({
      status: 200,
      description: 'User login successful!',
      type: PlayerLoginResponse,
    }),
    ApiQuery({ name: 'referrerId', required: false }),
    ApiBadRequestResponse({ description: 'User not verified.' }),
    ApiBadRequestResponse({ description: 'Invalid password!' }),
    ApiNotFoundResponse({ description: 'User with phone number not found!' }),
    UseInterceptors(
      SetCookieInterceptor,
      new TransformDataInterceptor(PlayerLoginResponse),
    ),
  );
}
