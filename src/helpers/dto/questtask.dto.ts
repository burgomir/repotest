import { TaskType } from '../constants/taskTypeEnum';
import { IsNotEmpty, IsString, IsUrl, IsEnum } from 'class-validator';

export class QuestTaskDto {
  @IsString()
  @IsNotEmpty()
  @IsUrl()
  link: string;

  @IsString()
  @IsNotEmpty()
  description: string;

  @IsEnum(TaskType)
  @IsNotEmpty()
  type: TaskType;
}