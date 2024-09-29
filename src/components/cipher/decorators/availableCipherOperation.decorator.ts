import { applyDecorators, UseInterceptors } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { Player } from 'src/common/decorators/isPlayer.decorator';
import { TransformDataInterceptor } from 'src/common/interceptors/transformData.interceptor';
import { CipherResponseType } from 'src/helpers/types/cipher.type';

export function AvailableCipherOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Get available ciphers' }),
    ApiNotFoundResponse({ description: 'Cipher not found!' }),
    ApiOkResponse({
      description: 'Availbale ciphers returned successfully',
      type: CipherResponseType,
    }),
    UseInterceptors(new TransformDataInterceptor(CipherResponseType)),
    Player(),
    ApiBearerAuth(),
  );
}
