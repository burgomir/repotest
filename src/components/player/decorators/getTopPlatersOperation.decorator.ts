import { applyDecorators, UseInterceptors } from '@nestjs/common';
import { ApiOkResponse, ApiOperation } from '@nestjs/swagger';
import { Public } from 'src/common/decorators/isPublic.decorator';
import { GetTopPlayersResponse } from '../responses/getTopPlayers.response';
import { TransformDataInterceptor } from 'src/common/interceptors/transformData.interceptor';

export function GetTopPlayersOperation() {
  return applyDecorators(
    Public(),
    ApiOperation({ summary: 'Get top 15 players by balance' }),
    ApiOkResponse({
      description: 'Return top 15 players by balance.',
      type: [GetTopPlayersResponse],
    }),
    UseInterceptors(new TransformDataInterceptor(GetTopPlayersResponse))
  );
}
