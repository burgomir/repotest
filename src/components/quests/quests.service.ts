import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { CreateQuestDto } from './dto/createQuest.dto';
import { GetQuestsQuery } from './dto/getQuests.query';
import { UpdateQuestDto } from './dto/updateQuest.dto';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { PlayersQuests } from '@prisma/client';
import { QuestsWithCompletion } from './interfaces/questsWithCompletion.interface';
import { GetQuestsResponse } from './responses/getQuests.response';
import { CreateQuestsResponse } from './responses/createQuests.response';
import { UpdateQuestsResponse } from './responses/updateQuests.response';
import { SuccessMessageType } from 'src/helpers/common/successMessage.type';
import { QuestsType } from 'src/helpers/types/quests.type';

@Injectable()
export class QuestsService {
  private logger = new Logger(QuestsService.name);

  constructor(private prismaService: PrismaService) {}

  async createQuest(dto: CreateQuestDto): Promise<CreateQuestsResponse> {
    this.logger.log('Создание нового квеста');
    const quest = await this.prismaService.quests.create({ data: { ...dto } });
    this.logger.log(`Квест с ID ${quest.id} успешно создан`);
    return { message: 'Quest created successfully', quest };
  }

  async getQuests(query: GetQuestsQuery): Promise<GetQuestsResponse> {
    this.logger.log('Получение списка квестов');
    const { take = 50, page = 1 } = query;
    const quests = await this.prismaService.quests.findMany({
      take: take,
      skip: (page - 1) * take,
      include: { media: true, questTasks: true },
    });
    const totalCount = await this.prismaService.quests.count();
    this.logger.log('Список квестов успешно получен');
    return {
      quests,
      totalCount,
    };
  }

  async updateQuest(
    questId: string,
    dto: UpdateQuestDto,
  ): Promise<UpdateQuestsResponse> {
    this.logger.log(`Обновление квеста с ID ${questId}`);
    const quest = await this.findQuestById(questId);
    const updatedQuest = await this.prismaService.quests.update({
      where: { id: quest.id },
      data: { ...dto },
    });
    this.logger.log(`Квест с ID ${quest.id} успешно обновлен`);
    return { message: 'Quest updated successfully', updatedQuest };
  }

  async deleteQuest(questId: string): Promise<SuccessMessageType> {
    this.logger.log(`Удаление квеста с ID ${questId}`);
    const quest = await this.findQuestById(questId);
    await this.prismaService.quests.delete({
      where: { id: quest.id },
    });
    this.logger.log(`Квест с ID ${questId} успешно удален`);
    return { message: 'Quest deleted successfully' };
  }

  async getPlayerQuests(
    currentUser: PlayersTokenDto,
  ): Promise<QuestsWithCompletion[]> {
    this.logger.log(`Получение квестов для игрока с ID ${currentUser.id}`);
  
    let total_quests = await this.prismaService.quests.findMany({
      include: { media: true, questTasks: true },
    });
    
    let quests = total_quests.filter(
      quest => quest.totalLimit === 0 || quest.totalLimit > quest.currentLimit
    );
    
  
    const playerQuestTasks = await this.prismaService.playersTasks.findMany({
      where: { playerId: currentUser.id },
    });
  
    const playerQuests = await this.prismaService.playersQuests.findMany({
      where: { playerId: currentUser.id },
    });
  
    const questsInfo: QuestsWithCompletion[] = quests.map((quest) => {
      const questTasks = quest.questTasks;
  
      let completedTaskIds = questTasks
        .filter((task) =>
          playerQuestTasks.some(
            (playerTask) => playerTask.taskId === task.id,
          ),
        )
        .map((task) => task.id);
  
      const playerQuest = playerQuests.find(
        (pq: PlayersQuests) => pq.questId === quest.id,
      );
  
      
      let isCompleted = completedTaskIds.length === questTasks.length;
      let completeDate = undefined;

      if (isCompleted && playerQuest) {
        isCompleted = !!playerQuest
        completeDate = playerQuest.completedAt || null;
      } else if (playerQuest && questTasks.length == 1) {
        isCompleted = true;
        completedTaskIds = questTasks.map((task) => task.id);
        completeDate = playerQuest.completedAt || null;
      } else {
        isCompleted = false;
      }
  
      return {
        id: quest.id,
        tgId: currentUser.tgId,
        link: quest.link,
        reward: quest.reward,
        terms: quest.terms,
        description: quest.description,
        isCompleted: isCompleted,
        media: quest.media,
        totalLimit: quest.totalLimit,
        completeDate: completeDate,
        currentLimit: quest.currentLimit,
        completedTaskIds: completedTaskIds,
      };
    });
  
    this.logger.log(
      `Квесты для игрока с ID ${currentUser.id} успешно получены`,
    );
  
    return questsInfo;
  }
  

  async findQuestById(questId: string) {
    this.logger.log(`Поиск квеста с ID ${questId}`);
    const quest = await this.prismaService.quests.findUnique({
      where: { id: questId },
    });
    if (!quest) {
      this.logger.error(`Квест с ID ${questId} не найден`);
      throw new NotFoundException('Quest not found');
    }
    return quest;
  }
}
