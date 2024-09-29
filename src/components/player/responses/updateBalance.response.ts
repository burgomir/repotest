export class UpdateBalanceResponse {
  message: string;
  battle: {
    newBalance: number; // Новый баланс после обновления
    bossStreak: number; // Новый стрик побед над боссом (если применимо)
    bossStreakHoney: number; // Дополнительный баланс за победу над боссом
  };
}
