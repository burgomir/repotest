import { ApiProperty } from '@nestjs/swagger';
import { ReferralPlayer } from 'src/helpers/types/referral.type';
import { Type } from 'class-transformer';

export class GetReferralsResponse {
  @Type(() => ReferralPlayer)
  @ApiProperty({ type: [ReferralPlayer] })
  referrals: ReferralPlayer[];

  @ApiProperty({ description: 'Total number of referrals' })
  totalCount: number;

  @ApiProperty({ description: 'Earned from referrals' })
  earnedFromReferralsNow: number;

  @ApiProperty({ description: 'Total sum of honey earned from referrals' })
  earnedFromReferralsTotal: number;
}
