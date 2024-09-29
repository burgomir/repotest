import { PartialType } from '@nestjs/swagger';
import { CreateRankDto } from './createRank.dto';

export class UpdateRankDto extends PartialType(CreateRankDto) {}
