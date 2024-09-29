import { ApiProperty, PickType } from '@nestjs/swagger';
import { PlayersType } from 'src/helpers/types/players.type';

export class GetTopPlayersResponse {
  players: RankedPlayers[];

  @ApiProperty({ description: 'Current page' })
  currentPage: number;
}

export class RankedPlayers extends PickType(PlayersType, [
  'userName',
  'balance',
]) {
  @ApiProperty({ description: 'Player rank' })
  rank: number;
}
