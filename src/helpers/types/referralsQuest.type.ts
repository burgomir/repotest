import { ApiProperty } from '@nestjs/swagger';
import { ReferralsQuest } from '@prisma/client';

export class ReferralsQuestType implements ReferralsQuest {
  @ApiProperty({
    description: 'Unique identifier for the referrals quest',
    example: '123e4567-e89b-12d3-a456-426614174005',
  })
  id: string;

  @ApiProperty({
    description: 'Number of referrals required to complete the quest',
    example: 5,
  })
  referralCount: number;

  @ApiProperty({
    description: 'Amount of reward given for completing the quest',
    example: 500,
  })
  reward: number;

  @ApiProperty({ description: 'Is quest completed' })
  isCompleted?: boolean;

  @ApiProperty({ description: 'The description of the referral quest' })
  description: string;

  @ApiProperty({ description: 'Is quest reward claimed' })
  isClaimed?: boolean;

  @ApiProperty({ description: 'Quest level' })
  level: number;
}
