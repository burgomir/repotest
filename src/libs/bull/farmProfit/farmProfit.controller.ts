import { Controller, Post } from '@nestjs/common';
import { FarmProfitService } from './farmProfit.service';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { CurrentUser } from 'src/common/decorators/currentUser.decorator';
import { PlayersTokenDto } from 'src/components/token/dto/token.dto';
import { AddFarmProfitOperation } from './decorators/addFarmProfitOperation.decorator';
import { Player } from 'src/common/decorators/isPlayer.decorator';
import { PlayerService } from 'src/components/player/player.service';

@ApiTags('farming')
@ApiBearerAuth()
@Controller('farm-profit')
export class FarmProfitController {
  constructor(
    private readonly farmProfitService: FarmProfitService,
    private playerService: PlayerService,
  ) {}

  @Post('start')
  @Player()
  @AddFarmProfitOperation()
  async addFarmProfit(@CurrentUser() currentUser: PlayersTokenDto) {
    return await this.playerService.startFarming(currentUser);
  }
}
