import { Injectable, Logger } from '@nestjs/common';
import { RedisService } from 'src/libs/redis/redis.service';
import { PrismaService } from 'src/utils/prisma/prisma.service';

@Injectable()
export class BalanceService {
  private readonly logger = new Logger(BalanceService.name);
  private readonly balancePrefix = 'user_balance';

  constructor(
    private readonly redisService: RedisService,
    private prismaService: PrismaService,
  ) {}

  async updateBalance(userId: string, amount: number): Promise<void> {
    const currentBalance = await this.redisService.get(
      this.balancePrefix,
      userId,
    );
    const newBalance =
      (currentBalance ? parseFloat(currentBalance) : 0) + amount;
    await this.redisService.set(
      this.balancePrefix,
      userId,
      newBalance.toString(),
    );
    this.logger.log(`Updated balance for user ${userId}: ${newBalance}`);
  }

  async getBalance(userId: string): Promise<number> {
    const balance = await this.redisService.get(this.balancePrefix, userId);
    return balance ? parseFloat(balance) : 0;
  }

  async getAllBalanceKeys(): Promise<string[]> {
    return this.redisService.getKeys(`${this.balancePrefix}:*`);
  }

  async deleteBalance(userId: string): Promise<void> {
    await this.redisService.delete(this.balancePrefix, userId);
    this.logger.log(`Deleted balance for user ${userId} from Redis`);
  }

  async getBossHp(playerId: string) {
    const playerOrc = await this.prismaService.playersOrcs.findUnique({
      where: { playerId },
    });
    return playerOrc.hp;
  }

  async getPlayerBalance(playerId: string) {
    const player = await this.prismaService.players.findUnique({
      where: { id: playerId },
    });

    return player.balance;
  }
}
