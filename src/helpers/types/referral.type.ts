import { Referrals } from '@prisma/client';
import { PlayersType } from './players.type';
import { Exclude, Type } from 'class-transformer';
import { ApiProperty, PickType } from '@nestjs/swagger';

export class ReferralType implements Referrals {
  @ApiProperty({
    description: 'Unique identifier for the referral',
    example: '123e4567-e89b-12d3-a456-426614174000',
  })
  id: string;

  @Exclude()
  referralId: string;

  @ApiProperty({
    description: 'Date when the referral was created',
    example: '2023-01-01T00:00:00Z',
  })
  createdAt: Date;

  @ApiProperty({ description: 'Referrer id' })
  referrerId: string;

  @ApiProperty({
    description: 'Associated player information',
    type: [PlayersType],
  })
  @Type(() => PlayersType)
  players: PlayersType[];
}

export class ReferralPlayer extends PickType(PlayersType, [
  'userName',
  'balance',
] as const) {}
