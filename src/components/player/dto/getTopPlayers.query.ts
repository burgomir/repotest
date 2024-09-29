import { PickType } from '@nestjs/swagger';
import { IsOptional, Max, Min } from 'class-validator';
import { PageOptionsDto } from 'src/helpers/dto/page.dto';

export class GetTopPlayers extends PickType(PageOptionsDto, ['take', 'page']) {
  @Min(30)
  @IsOptional()
  @Max(30)
  take?: number;

  @Min(1)
  @IsOptional()
  @Max(4)
  page?: number;
}
