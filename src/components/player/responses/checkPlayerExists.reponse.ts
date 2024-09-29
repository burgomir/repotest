import { ApiProperty, PickType } from '@nestjs/swagger';
import { PlayersType } from 'src/helpers/types/players.type';

export class CheckPlayerExistsResponse {
  resource: string;
  isExists: boolean;
}