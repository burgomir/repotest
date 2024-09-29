import { IsNotEmpty, IsNumber, IsString, IsUrl, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { QuestTaskDto } from './questtask.dto';

export class QuestsDto {
  @IsString()
  @IsNotEmpty()
  @IsUrl()
  link: string;

  @IsNotEmpty()
  @IsNumber()
  reward: number;

  @IsString()
  @IsNotEmpty()
  terms: string;

  @IsString()
  @IsNotEmpty()
  description: string;

  @IsNumber()
  totalLimit: number;

  @IsNumber()
  currentLimit: number;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => QuestTaskDto)
  tasks: QuestTaskDto[];  // Список заданий внутри квеста
}