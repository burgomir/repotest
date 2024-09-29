import { applyDecorators } from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiBody,
  ApiCreatedResponse,
  ApiOperation,
} from '@nestjs/swagger';
import { RankType } from 'src/helpers/types/rank.type';
import { CreateRankDto } from '../dto/createRank.dto';

export function CreateRankOperation() {
  return applyDecorators(
    ApiCreatedResponse({
      description: 'Rank created successfully!',
      type: RankType,
    }),
    ApiBody({ type: CreateRankDto }),
    ApiBadRequestResponse({ description: 'Bad request' }),
    ApiOperation({ summary: 'Create a new rank' }),
  );
}
