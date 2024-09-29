import {
  Controller,
  Get,
  Post,
  Delete,
  Body,
  Param,
  Query,
  Patch,
  ParseUUIDPipe,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { QuestsService } from './quests.service';
import { CreateQuestDto } from './dto/createQuest.dto';
import { UpdateQuestDto } from './dto/updateQuest.dto';
import { GetQuestsQuery } from './dto/getQuests.query';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { QuestsWithCompletion } from 'src/helpers/types/quests.type';
import { GetQuestsResponse } from './responses/getQuests.response';
import { CreateQuestsResponse } from './responses/createQuests.response';
import { UpdateQuestsResponse } from './responses/updateQuests.response';
import { SuccessMessageType } from 'src/helpers/common/successMessage.type';
import { CurrentUser } from 'src/common/decorators/currentUser.decorator';
import { CreateQuestOperation } from './decorators/createQuestOperation.decorator';
import { GetQuestsOperation } from './decorators/getQuestsOperation.decorator';
import { UpdateQuestOperation } from './decorators/updateQuestOperation.decorator';
import { DeleteQuestOperation } from './decorators/deleteQuestOperation.decorator';
import { GetPlayerQuestsOperation } from './decorators/getPlayerQuestsOperation.decorator';
import { CompleteQuestOperation } from './decorators/completeQuestOperation.decorator';
import { QuestProfitService } from 'src/libs/bull/questProfit/questProfit.service';

@ApiTags('quests')
@ApiBearerAuth()
@Controller('quests')
export class QuestsController {
  constructor(
    private readonly questsService: QuestsService,
    private questProfitService: QuestProfitService,
  ) {}

  @Post()
  @CreateQuestOperation()
  async createQuest(
    @Body() dto: CreateQuestDto,
  ): Promise<CreateQuestsResponse> {
    const quest = await this.questsService.createQuest(dto);
    return quest;
  }

  @Get()
  @GetQuestsOperation()
  async getQuests(@Query() query: GetQuestsQuery): Promise<GetQuestsResponse> {
    const quests = await this.questsService.getQuests(query);
    return quests;
  }

  @Patch(':questId')
  @UpdateQuestOperation()
  async updateQuest(
    @Param('questId') questId: string,
    @Body() dto: UpdateQuestDto,
  ): Promise<UpdateQuestsResponse> {
    const result = await this.questsService.updateQuest(questId, dto);
    return result;
  }

  @Delete(':questId')
  @DeleteQuestOperation()
  async deleteQuest(
    @Param('questId') questId: string,
  ): Promise<SuccessMessageType> {
    const result = await this.questsService.deleteQuest(questId);
    return result;
  }

  @Get('player')
  @GetPlayerQuestsOperation()
  async getPlayerQuests(
    @CurrentUser() currentUser: PlayersTokenDto,
  ): Promise<QuestsWithCompletion[]> {
    const quests = await this.questsService.getPlayerQuests(currentUser);
    return quests;
  }

  @Post('complete-task/:questId')
  @CompleteQuestOperation()
  async completeQuest(
    @Param('questId', ParseUUIDPipe) questId: string,
    @CurrentUser() currentUser: PlayersTokenDto,
  ) {
    return this.questProfitService.completeQuest(currentUser, questId);
  }

  @Post('complete-task/:questId/:taskId')
  @CompleteQuestOperation()
  async completeTaskInQuest(
    @Param('questId', ParseUUIDPipe) questId: string,
    @Param('taskId', ParseUUIDPipe) taskId: string,
    @CurrentUser() currentUser: PlayersTokenDto,
  ) {
    return this.questProfitService.completeTaskInQuest(currentUser, questId, taskId);
  }
}
