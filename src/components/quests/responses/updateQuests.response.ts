import { ApiProperty, PickType } from '@nestjs/swagger';
import { SuccessResponse } from '../../../helpers/common/successResponse.type';
import { QuestsType } from 'src/helpers/types/quests.type';
import { Type } from 'class-transformer';

export class UpdateQuestsResponse extends PickType(SuccessResponse, [
  'message',
] as const) {
  @Type(() => QuestsType)
  @ApiProperty({ type: QuestsType })
  updatedQuest: QuestsType;
}
