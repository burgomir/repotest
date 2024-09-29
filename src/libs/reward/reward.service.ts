import { Injectable, Logger } from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma/prisma.service';

type Reward = {
  nctr?: number;
  crystal?: number;
};

@Injectable()
export class RewardService {
  private readonly logger = new Logger(RewardService.name);

  constructor(private readonly prisma: PrismaService) { }

  getCurrentSegment(): number {
    const currentHour = new Date().getHours();
    const segmentDuration = 24 / 6;

    return Math.floor(currentHour / segmentDuration);
  }

  private getRandomInt(max: number): number {
    return Math.floor(Math.random() * max) + 1;
  }


  private async getRewards() {
    let counters = await this.prisma.rewardCounters.findFirst();

    if (!counters) {
      counters = await this.prisma.rewardCounters.create({
        data: {
          legendary: 0,
          rare: 0,
          common: 0,
          maxLegendary: 1,
          maxRare: 2,
          maxNctr: 50,
          maxCrystal: 100,
          interval: [[{ "crystal": 3 }, { "crystal": 1 }, { "crystal": 2 }, { "nctr": 1, "crystal": 3 }, { "crystal": 2 }, { "crystal": 1 }, { "crystal": 1 }, { "crystal": 2 }, { "crystal": 2 }, { "crystal": 3 }], [{ "nctr": 2, "crystal": 1 }, { "nctr": 3, "crystal": 1 }], [{ "crystal": 1 }, { "crystal": 1 }, { "crystal": 3 }, { "crystal": 3 }, { "crystal": 2 }], [{ "crystal": 2 }, { "nctr": 22, "crystal": 20 }, { "crystal": 1 }, { "crystal": 3 }, { "nctr": 2, "crystal": 2 }, { "crystal": 3 }, { "crystal": 2 }, { "crystal": 1 }, { "crystal": 2 }], [{ "crystal": 1 }, { "nctr": 6, "crystal": 5 }, { "crystal": 3 }, { "crystal": 1 }, { "crystal": 3 }], [{ "crystal": 3 }, { "crystal": 1 }, { "nctr": 1, "crystal": 3 }, { "nctr": 3, "crystal": 3 }, { "nctr": 10, "crystal": 5 }, { "crystal": 1 }, { "crystal": 2 }, { "crystal": 1 }]],
        },
      });
    }

    return counters;
  }

  private shuffleArray<T>(array: T[]): T[] {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
  }

  async resetRewards() {
    const counters = await this.getRewards();

    const segments: Reward[][] = [[], [], [], [], [], []];

    let totalNCTR = counters.maxNctr;
    let totalCrystals = counters.maxCrystal;

    const distributeInRange = (min: number, max: number): number => {
      return Math.floor(Math.random() * (max - min + 1)) + min;
    };


    const addRewardToSegment = (index: number, nctr?: number, crystal?: number): void => {
      segments[index].push({ nctr, crystal });
    };


    for (let i = 0; i < counters.maxLegendary; i++) {
      const nctrAmount = distributeInRange(20, 25);
      const crystalAmount = distributeInRange(20, 25);
      const randomSegment = Math.floor(Math.random() * 6);
      addRewardToSegment(randomSegment, nctrAmount, crystalAmount);
      totalNCTR -= nctrAmount;
      totalCrystals -= crystalAmount;
    }


    for (let i = 0; i < counters.maxRare; i++) {
      const nctrAmount = distributeInRange(5, 10);
      const crystalAmount = distributeInRange(5, 10);
      const randomSegment = Math.floor(Math.random() * 6);
      addRewardToSegment(randomSegment, nctrAmount, crystalAmount);
      totalNCTR -= nctrAmount;
      totalCrystals -= crystalAmount;
    }


    while (totalNCTR > 0 || totalCrystals > 0) {
      const nctrAmount = totalNCTR > 0 ? Math.min(totalNCTR, distributeInRange(1, 3)) : undefined;
      const crystalAmount = totalCrystals > 0 ? Math.min(totalCrystals, distributeInRange(1, 3)) : undefined;
      const randomSegment = Math.floor(Math.random() * 6);

      if (nctrAmount || crystalAmount) {
        addRewardToSegment(randomSegment, nctrAmount, crystalAmount);
        totalNCTR -= nctrAmount || 0;
        totalCrystals -= crystalAmount || 0;
      }
    }


    for (let i = 0; i < segments.length; i++) {
      segments[i] = this.shuffleArray(segments[i]);
    }


    const shuffledSegments = this.shuffleArray(segments);


    await this.prisma.rewardCounters.update({
      where: { id: counters.id },
      data: {
        interval: shuffledSegments,
      },
    });

    this.logger.log('Rewards have been reset and saved into rewardCounters.interval.');
  }

  async getRewardFromCurrentSegment(bossStreak: number, referralsCount: number, totalQuests: number, totalPlayersQuests: number): Promise<Reward | null> {
    const currentSegment = this.getCurrentSegment();
    this.logger.log(`Current segment: ${currentSegment}`);

    const rewards = await this.getRewards();
    const rewardsInSegment = rewards.interval[currentSegment];

    if (rewardsInSegment.length === 0) {
      return { nctr: undefined, crystal: undefined };
    }

    // Изначальный шанс без модификаторов
    let chance = this.getRandomInt(2500);

    this.logger.log(`Basic chance: ${chance}`)

    // Увеличение шансов на основе bossStreak
    if (bossStreak >= 30) {
      chance = Math.floor(chance * 0.25); // Уменьшаем случайное значение на 75%, увеличивая шанс
      this.logger.log('Boss streak >= 30: шанс увеличен на 75%');
    }

    // Увеличение шансов на основе referralsCount
    if (referralsCount >= 100) {
      chance = Math.floor(chance * 0.25); // Ещё на 75% при большом числе рефералов
      this.logger.log('Referrals count >= 100: шанс увеличен на 75%');
    }

    // Увеличение шансов на основе totalPlayersQuests
    if (totalPlayersQuests >= totalQuests) {
      chance = Math.floor(chance * 0.25); // Ещё на 75% при большом числе выполненных квестов относительно общего количества квестов
      this.logger.log('Referrals count >= 100: шанс увеличен на 75%');
    }

    this.logger.log(`Changed chance: ${chance}`)

    let selectedReward: Reward | null = null;

    if (chance === 1) {
      this.logger.log('Попытка найти большую награду!');
      selectedReward = this.findBigReward(rewardsInSegment) || this.findMediumReward(rewardsInSegment) || this.findSmallReward(rewardsInSegment);
    } else if (chance <= 2) {
      this.logger.log('Попытка найти среднюю награду!');
      selectedReward = this.findMediumReward(rewardsInSegment) || this.findSmallReward(rewardsInSegment);
    } else if (chance <= 10) {
      this.logger.log('Попытка найти маленькую награду!');
      selectedReward = this.findSmallReward(rewardsInSegment);
    }

    if (selectedReward) {
      const rewardIndex = rewardsInSegment.findIndex(reward => this.compareRewards(reward, selectedReward));
      if (rewardIndex !== -1) {
        rewardsInSegment.splice(rewardIndex, 1); // Убираем награду из списка
      }

      rewards.interval[currentSegment] = rewardsInSegment;
      await this.prisma.rewardCounters.update({
        where: { id: rewards.id },
        data: {
          interval: rewards.interval,
        },
      });

      this.logger.log('Награда успешно вырезана из JSON и обновлена в базе данных.');
    }

    return selectedReward;
  }



  private compareRewards(reward1: Reward, reward2: Reward): boolean {
    return reward1.nctr === reward2.nctr && reward1.crystal === reward2.crystal;
  }


  private findBigReward(rewards: Reward[]): Reward | null {
    const bigReward = rewards.find(reward => reward.nctr !== undefined);
    if (bigReward) {
      this.logger.log('Найдена большая награда!');
      return bigReward;
    }
    return null;
  }


  private findMediumReward(rewards: Reward[]): Reward | null {
    const mediumReward = rewards.find(reward => reward.crystal !== undefined && reward.nctr === undefined);
    if (mediumReward) {
      this.logger.log('Найдена средняя награда!');
      return mediumReward;
    }
    return null;
  }


  private findSmallReward(rewards: Reward[]): Reward | null {
    const smallReward = rewards.find(reward => reward.nctr === undefined && reward.crystal === undefined);
    if (smallReward) {
      this.logger.log('Найдена маленькая награда!');
      return smallReward;
    }
    return null;
  }
}
