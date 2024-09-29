import { ApiProperty } from '@nestjs/swagger';
import { Players } from '@prisma/client';
import { Exclude, Type } from 'class-transformer';
import { PlayerOrcType } from './playerOrc.type';
import { PlayerProgressType } from './playerProgress.type';
import { PlayerRanksType } from './playerRanks.type';

export class PlayersType implements Players {
  @ApiProperty({
    description: 'Unique identifier for the player',
    example: '123e4567-e89b-12d3-a456-426614174000',
  })
  id: string;

  @ApiProperty({
    description: 'Latest amount of honey the player has',
    example: 500.0,
  })
  honeyLatest: number;

  @ApiProperty({
    description: 'Maximum amount of honey the player can have',
    example: 1000.0,
  })
  honeyMax: number;

  @ApiProperty({
    description: 'Balance of the player',
    example: 1000.5,
  })
  balance: number;

  @ApiProperty({
    description: 'Balance NCTR of the player',
    example: 10
  })
  balance_nctr: number;

  @ApiProperty({
    description: 'Balance Crystal of the player',
    example: 10
  })
  balance_crystal: number;

  @Exclude()
  lastLogin: Date;

  @Exclude()
  lastLogout: Date;

  @ApiProperty({
    description: "ID of the player's current level",
    example: 'level123',
  })
  levelId: string;

  @ApiProperty({
    description: 'ID of the referral who referred the player',
    example: 'referrer123',
  })
  referredById: string;

  @ApiProperty({
    description: 'Telegram ID of the player',
    example: 123456789,
  })
  tgId: string;

  @ApiProperty({
    description: 'Indicates if the player has premium status',
    example: true,
  })
  isPremium: boolean;

  @ApiProperty({
    description: 'Username of the player',
    example: 'johndoe',
  })
  userName: string;

  @ApiProperty({ description: 'Total profit from referrals' })
  totalReferralProfit: number;

  @ApiProperty({
    description: 'Date and time when the player was created',
    example: '2023-01-01T00:00:00Z',
  })
  createdAt: Date;

  @ApiProperty({ description: 'Farming date' })
  farmingDate: Date;

  @ApiProperty({ description: 'Farming end date' })
  farmingEndDate: Date;

  @ApiProperty({ description: 'Player nickname' })
  nickName: string;

  @ApiProperty({ type: PlayerOrcType })
  @Type(() => PlayerOrcType)
  playerOrcs?: PlayerOrcType;

  @ApiProperty({ type: [PlayerProgressType] })
  @Type(() => PlayerProgressType)
  playerProgress?: PlayerProgressType[];

  @ApiProperty({ type: [PlayerRanksType] })
  @Type(() => PlayerRanksType)
  playerRanks?: PlayerRanksType[];

  @ApiProperty({ description: 'Init data' })
  initData?: string;
}
