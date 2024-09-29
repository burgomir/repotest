import { Body, Controller, Get, Param, Patch, Query, Headers, UnauthorizedException } from '@nestjs/common';
import { PlayerService } from './player.service';
import { CurrentUser } from 'src/common/decorators/currentUser.decorator';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { UpdateBalanceDto } from './dto/updateBalance.dto';
import { ApiTags } from '@nestjs/swagger';
import * as jwt from 'jsonwebtoken';
import { PlayersType } from 'src/helpers/types/players.type';
import { SuccessMessageType } from 'src/helpers/common/successMessage.type';
import { GetMeOperation } from './decorators/getMeOperation.decorator';
import { CheckPlayerExistsOperation } from './decorators/checkPlayerExistsOperation.decorator';
import { UpdatePlayerBalanceOperation } from './decorators/updateBalanceOperation.decorator';
import { GetTopPlayersOperation } from './decorators/getTopPlatersOperation.decorator';
import { GetPlayerByTelegramIdOperation } from './decorators/getPlayerByTelegramIdOperation.decorator';
import { GetTopPlayersResponse } from './responses/getTopPlayers.response';
import { GetTopPlayers } from './dto/getTopPlayers.query';
import { ConfigService } from '@nestjs/config';
import { TokenService } from '../../components/token/token.service';
import { CheckPlayerExistsResponse } from './responses/checkPlayerExists.reponse';


@ApiTags('players')
@Controller('player')
export class PlayerController {
  constructor(
    private readonly playerService: PlayerService,
    private tokenService: TokenService,
    private configService: ConfigService,
  ) {}

  private decodeToken(authHeader: string): PlayersTokenDto {
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new UnauthorizedException('Invalid or missing Bearer token');
    }

    const token = authHeader.split(' ')[1];
    try {
      
      return jwt.verify(token, this.configService.getOrThrow<string>('JWT_ACCESS_SECRET')) as PlayersTokenDto;
    } catch (err) {
      throw new UnauthorizedException('Invalid or expired token');
    }
  }

  @Get('/me')
  @GetMeOperation()
  async getMe(@Headers('authorization') authHeader: string): Promise<PlayersType> {
    const currentUser = this.decodeToken(authHeader);
    var user = await this.playerService.getMe(currentUser)
    return user;
  }

  @Patch('/balance')
  @UpdatePlayerBalanceOperation()
  async updateBalance(
    @CurrentUser() currentUser: PlayersTokenDto,
    @Body() dto: UpdateBalanceDto,
  ): Promise<SuccessMessageType> {
    return await this.playerService.updateBalance(currentUser, dto);
  }

  @Get('top')
  @GetTopPlayersOperation()
  getTopPlayers(@Query() query: GetTopPlayers): Promise<GetTopPlayersResponse> {
    return this.playerService.getTopPlayers(query);
  }

  @Get(':telegramId')
  @GetPlayerByTelegramIdOperation()
  async getPlayerByTelegramId(
    @Param('telegramId') telegramId: string,
  ): Promise<PlayersType> {
    return await this.playerService.getPlayerByTelegramId(telegramId);
  }

  @Get('/user_exists/:resource/:telegramId')
  @CheckPlayerExistsOperation()
  async checkPlayerExistsInBot(
    @Param('resource') resource: string,
    @Param('telegramId') telegramId: string,
  ): Promise<CheckPlayerExistsResponse> {
    return await this.playerService.checkPlayerExists(resource, telegramId);
  }
}
