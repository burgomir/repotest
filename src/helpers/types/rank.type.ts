import { ApiProperty } from '@nestjs/swagger';

export class RankType {
  @ApiProperty({ description: 'Unique identifier for the rank' })
  id: string;

  @ApiProperty({ description: 'Bonus amount for the rank' })
  bonusAmount: number;

  @ApiProperty({ description: 'Description of the rank' })
  description: string;

  @ApiProperty({ description: 'Rank level' })
  rank: number;

  @ApiProperty({ description: 'Name of the rank' })
  name: string;

  @ApiProperty({ description: 'Required amount to achieve the rank' })
  requiredAmount: number;
}
