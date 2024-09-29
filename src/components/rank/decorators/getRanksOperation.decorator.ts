import { applyDecorators } from '@nestjs/common';
import { ApiOkResponse, ApiOperation } from '@nestjs/swagger';
import { RankType } from 'src/helpers/types/rank.type';

export function GetRanksOperation() {
  return applyDecorators(
    ApiOperation({ summary: 'Get all ranks' }),
    ApiOkResponse({ description: 'Get all ranks', type: [RankType] }),
  );
}
