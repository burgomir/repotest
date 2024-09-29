import { PartialType } from '@nestjs/swagger';
import { CreateQuestDto } from './createQuest.dto';

export class UpdateQuestDto extends PartialType(CreateQuestDto) {}
