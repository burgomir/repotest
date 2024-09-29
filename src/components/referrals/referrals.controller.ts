import {
  Controller,
  Get,
  Post,
  Body,
  Query,
  Delete,
  Param,
  Patch,
  ParseUUIDPipe,
} from '@nestjs/common';
import { ReferralsService } from './referrals.service';
import { ApiTags } from '@nestjs/swagger';
import { CurrentUser } from 'src/common/decorators/currentUser.decorator';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { GetReferralsQuery } from './dto/getReferralsQuery.dto';
import { CreateReferralQuestDto } from './dto/createReferralRequest.dto';
import { UpdateReferralQuestDto } from './dto/updateReferralRequest.dto';
import { GetReferralsOperation } from './decorators/getReferralsOperation.decorator';
import { CollectReferralProfitOperation } from './decorators/collectReferralProfitOperation.decorator';
import { CreateReferralQuestOperation } from './decorators/createReferralQuestOperation.decorator';
import { UpdateReferralQuestOperation } from './decorators/updateReferralQuestOperation.decorator';
import { DeleteReferralQuestOperation } from './decorators/deleteReferralQuestOperation.decorator';
import { GetReferralQuestOperation } from './decorators/getReferralQuestOperation.decorator';
import { GetReferralQuestProfitOperation } from './decorators/getReferralQuestProfitOperation.decorator';

@ApiTags('referrals')
@Controller('referrals')
export class ReferralsController {
  constructor(private readonly referralsService: ReferralsService) {}

  @Get()
  @GetReferralsOperation()
  async getReferrals(
    @CurrentUser() currentUser: PlayersTokenDto,
    @Query() query: GetReferralsQuery,
  ) {
    return await this.referralsService.getReferrals(currentUser, query);
  }

  @Post('collect-profit')
  @CollectReferralProfitOperation()
  async collectReferralProfit(@CurrentUser() currentUser: PlayersTokenDto) {
    return await this.referralsService.collectReferralProfit(currentUser);
  }

  @Post('quest')
  @CreateReferralQuestOperation()
  async createReferralQuest(@Body() dto: CreateReferralQuestDto) {
    const referralQuest = await this.referralsService.createReferralQuest(dto);
    return referralQuest;
  }

  @Patch('quest/:referralQuestId')
  @UpdateReferralQuestOperation()
  async updateReferralQuest(
    @Param('referralQuestId') referralQuestId: string,
    @Body() dto: UpdateReferralQuestDto,
  ) {
    const result = await this.referralsService.updateReferralQuest(
      referralQuestId,
      dto,
    );
    return result;
  }

  @Delete('quest/:referralQuestId')
  @DeleteReferralQuestOperation()
  async deleteReferralQuest(@Param('referralQuestId') referralQuestId: string) {
    const result =
      await this.referralsService.deleteReferralQuest(referralQuestId);
    return result;
  }

  @Get('quest')
  @GetReferralQuestOperation()
  async getReferralQuest(@CurrentUser() currentUser: PlayersTokenDto) {
    const referralQuest =
      await this.referralsService.getReferralQuests(currentUser);
    return referralQuest;
  }

  @Post('quest/collect-profit/:referralQuestId')
  @GetReferralQuestProfitOperation()
  async getReferralQuestsProfit(
    @CurrentUser() currentUser: PlayersTokenDto,
    @Param('referralQuestId', ParseUUIDPipe) referralQuestId: string,
  ) {
    return await this.referralsService.getReferralQuestsProfit(
      currentUser,
      referralQuestId,
    );
  }
}
