import { applyDecorators, UseInterceptors } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { SetCookieInterceptor } from 'src/common/interceptors/setCookie.interceptor';
import { TransformDataInterceptor } from 'src/common/interceptors/transformData.interceptor';
import { CheckPlayerExistsResponse } from '../responses/checkPlayerExists.reponse';

export function CheckPlayerExistsOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Check player exists in resource by tg id' }),
    ApiOkResponse({description: 'Player checked by id successfully!'}),
    ApiNotFoundResponse({ description: 'Player not found!' }),
    UseInterceptors(
      SetCookieInterceptor,
      new TransformDataInterceptor(CheckPlayerExistsResponse),
    )
  );
}
