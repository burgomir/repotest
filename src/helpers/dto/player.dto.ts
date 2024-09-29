import { PickType } from '@nestjs/swagger';
import {
  IsBoolean,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';
import { PlayersType } from '../types/players.type';

export class PlayerDto extends PickType(PlayersType, [
  'userName',
  'tgId',
  'isPremium',
  'balance',
  'honeyLatest',
  'honeyMax',
  'nickName',
  'initData'
] as const) {
  @IsString()
  userName: string;

  @IsNotEmpty()
  @IsString()
  tgId: string;

  @IsBoolean()
  @IsNotEmpty()
  isPremium: boolean;

  @IsNumber()
  @IsNotEmpty()
  balance: number;

  @IsString()
  nickName: string;

  @IsNumber()
  @IsNotEmpty()
  honeyLatest: number;

  @IsNotEmpty()
  @IsNumber()
  honeyMax: number;

  @IsString()
  initData: string;
}
