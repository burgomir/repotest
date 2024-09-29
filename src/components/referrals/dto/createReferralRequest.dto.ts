import { PickType } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsString } from 'class-validator';
import { ReferralsQuestType } from 'src/helpers/types/referralsQuest.type';

export class CreateReferralQuestDto extends PickType(ReferralsQuestType, [
  'reward',
  'description',
  'referralCount',
  'level',
] as const) {
  @IsNumber()
  @IsNotEmpty()
  referralCount: number;

  @IsNumber()
  @IsNotEmpty()
  reward: number;

  @IsString()
  @IsNotEmpty()
  description: string;

  @IsNumber()
  @IsNotEmpty()
  level: number;
}
