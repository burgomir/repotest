import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, IsNumber, IsOptional } from 'class-validator';
import { RankType } from '../types/rank.type';

export class RankDto extends RankType {
  @ApiProperty({ example: '1', description: 'The ID of the rank' })
  @IsNotEmpty()
  @IsString()
  id: string;

  @ApiProperty({ example: 'Beginner', description: 'The name of the rank' })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty({
    example: 'Reach 1000 points to achieve this rank',
    description: 'Description of the rank',
  })
  @IsNotEmpty()
  @IsString()
  description: string;

  @ApiProperty({
    example: 1000,
    description: 'The required amount to achieve this rank',
  })
  @IsNotEmpty()
  @IsNumber()
  requiredAmount: number;

  @ApiProperty({
    example: 50.0,
    description: 'The bonus amount rewarded upon achieving this rank',
  })
  @IsOptional()
  @IsNumber()
  bonusAmount: number;
}
