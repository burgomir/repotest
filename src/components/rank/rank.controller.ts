import {
  Controller,
  Get,
  Post,
  Delete,
  Param,
  Body,
  Patch,
  ParseUUIDPipe,
} from '@nestjs/common';
import {
  ApiTags,
  ApiBearerAuth,
  ApiOkResponse,
  ApiNotFoundResponse,
} from '@nestjs/swagger';
import { RankDto } from 'src/helpers/dto/rank.dto';
import { RanksService } from './rank.service';
import { CurrentUser } from 'src/common/decorators/currentUser.decorator';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { RankType } from 'src/helpers/types/rank.type';
import { SuccessMessageType } from 'src/helpers/common/successMessage.type';
import { CreateRankDto } from './dto/createRank.dto';
import { UpdateRankDto } from './dto/updateRank.dto';
import { CreateRankOperation } from './decorators/createRankOperation.decorator';
import { UpdateRankOperation } from './decorators/updateRankOperation.decorator';
import { DeleteRankOperation } from './decorators/deleteRankOperation.decorator';
import { GetRanksOperation } from './decorators/getRanksOperation.decorator';
import { GetPlayerRanksOperation } from './decorators/getPlayerRanksOperation.decorator';
import { GetRankByIdOperation } from './decorators/getRankByIdOperation.decorator';
import { Player } from 'src/common/decorators/isPlayer.decorator';

@ApiTags('ranks')
@ApiBearerAuth()
@Controller('ranks')
export class RanksController {
  constructor(private readonly ranksService: RanksService) {}

  @Post()
  @CreateRankOperation()
  async create(@Body() rankDto: CreateRankDto): Promise<RankType> {
    return await this.ranksService.create(rankDto);
  }

  @Patch(':rankId')
  @UpdateRankOperation()
  async update(
    @Param('rankId') rankId: string,
    @Body() rankDto: UpdateRankDto,
  ): Promise<RankDto> {
    const updatedRank = await this.ranksService.update(rankId, rankDto);
    return updatedRank;
  }

  @Delete(':rankId')
  @DeleteRankOperation()
  async delete(@Param('rankId') rankId: string): Promise<SuccessMessageType> {
    return await this.ranksService.delete(rankId);
  }

  @Get()
  @GetRanksOperation()
  async getAll(): Promise<RankDto[]> {
    const ranks = await this.ranksService.getAll();
    return ranks;
  }

  @Get('player')
  @GetPlayerRanksOperation()
  async getPlayerRanks(@CurrentUser() currentUser: PlayersTokenDto) {
    return await this.ranksService.getPlayerRanks(currentUser.id);
  }

  @Get(':rankId')
  @GetRankByIdOperation()
  async findById(@Param('rankId') rankId: string): Promise<RankDto> {
    const rank = await this.ranksService.findById(rankId);
    return rank;
  }

  @Post('collect-profit/:rankId')
  @ApiOkResponse({ description: 'Rank profit collected!' })
  @ApiNotFoundResponse({ description: 'Rank profit not found!' })
  @Player()
  async collectProfit(
    @Param('rankId', ParseUUIDPipe) rankId: string,
    @CurrentUser() currentUser: PlayersTokenDto,
  ) {
    return await this.ranksService.collectRankProfit(currentUser, rankId);
  }
}
