import { applyDecorators } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiOperation } from '@nestjs/swagger';
import { Player } from 'src/common/decorators/isPlayer.decorator';
import { GetPlayerRanksType } from '../responses/getPlayerRanks.response';

export function GetPlayerRanksOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Get player  ranks' }),
    ApiOkResponse({
      type: GetPlayerRanksType,
      description: 'Get player ranks',
    }),
    Player(),
    ApiBearerAuth(),
  );
}
