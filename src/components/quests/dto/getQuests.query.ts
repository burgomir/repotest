import { PickType } from '@nestjs/swagger';
import { PageOptionsDto } from 'src/helpers/dto/page.dto';

export class GetQuestsQuery extends PickType(PageOptionsDto, [
  'take',
  'page',
] as const) {}
