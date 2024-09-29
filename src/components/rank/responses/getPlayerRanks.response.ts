import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { RankType } from 'src/helpers/types/rank.type';

class RankWithStatusType {
  @ApiProperty({ description: 'Rank details' })
  @Type(() => RankType)
  rank: RankType;

  @ApiProperty({ description: 'Is rank completed' })
  isCompleted: boolean;

  @ApiProperty({ description: 'Is rank reward collected' })
  isCollected: boolean;
}

export class GetPlayerRanksType {
  @ApiProperty({ description: 'Current player level' })
  currentLevel: number;

  @ApiProperty({
    type: RankWithStatusType,
    description: 'Users next rank',
    nullable: true,
  })
  @Type(() => RankWithStatusType)
  nextRank: RankWithStatusType | null;

  @ApiProperty({ type: [RankWithStatusType] })
  @Type(() => RankWithStatusType)
  ranks: RankWithStatusType[];
}
