import { ApiProperty } from '@nestjs/swagger';
import { Quests } from '@prisma/client';
import { MediaType } from './media.type';
import { Type } from 'class-transformer';

export class QuestsType implements Quests {
  @ApiProperty({ description: 'The unique identifier of the quest' })
  id: string;

  @ApiProperty({ description: 'The link related to the quest' })
  link: string;

  @ApiProperty({ description: 'The reward amount for completing the quest' })
  reward: number;

  @ApiProperty({ description: 'The terms and conditions of the quest' })
  terms: string;

  @ApiProperty({ description: 'The description of the quest' })
  description: string;

  @Type(() => MediaType)
  @ApiProperty({ type: MediaType })
  media?: MediaType;

  @ApiProperty({ description: 'Total quest usage limit'})
  totalLimit: number;
  
  @ApiProperty({ description: 'Current quest usage limit'})
  currentLimit: number;
}

export class QuestsWithCompletion implements Quests {
  @ApiProperty({ description: 'The unique identifier of the quest' })
  id: string;

  @ApiProperty({ description: 'The link related to the quest' })
  link: string;

  @ApiProperty({ description: 'The reward amount for completing the quest' })
  reward: number;

  @ApiProperty({ description: 'The terms and conditions of the quest' })
  terms: string;

  @ApiProperty({ description: 'Is quest completed or not' })
  isCompleted: boolean;

  @ApiProperty({ description: 'The description of the quest' })
  description: string;

  @ApiProperty({ description: 'Total quest usage limit'})
  totalLimit: number;

  @ApiProperty({ description: 'Current quest usage limit'})
  currentLimit: number;
}
