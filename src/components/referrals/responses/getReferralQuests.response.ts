import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { ReferralsQuestType } from 'src/helpers/types/referralsQuest.type';

export class GetReferralQuestsResponse {
  @ApiProperty({ description: 'Current quest level' })
  currentLevel: number;

  @ApiProperty({ type: ReferralsQuestType, nullable: true })
  nextQuest: ReferralsQuestType | null;

  @ApiProperty({ type: [ReferralsQuestType] })
  @Type(() => ReferralsQuestType)
  quests: ReferralsQuestType[];
}
