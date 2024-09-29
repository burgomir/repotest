import { Quests } from '@prisma/client';

export interface QuestsWithCompletion extends Quests {
  isCompleted: boolean;

  totalLimit: number;

  currentLimit: number;
}
