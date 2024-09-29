import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { QuestsWithCompletion } from 'src/helpers/types/quests.type';

export class GetPlayerQuestsType {
  @Type(() => QuestsWithCompletion)
  @ApiProperty({ type: [QuestsWithCompletion] })
  quests: QuestsWithCompletion[];

  @ApiProperty({ description: 'Total count of quests' })
  totalCount: number;
}
