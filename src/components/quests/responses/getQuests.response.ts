import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { QuestsType } from 'src/helpers/types/quests.type';

export class GetQuestsResponse {
  @ApiProperty({ type: [QuestsType] })
  @Type(() => QuestsType)
  quests: QuestsType[];

  @ApiProperty({ description: 'Quests total count' })
  totalCount: number;
}
