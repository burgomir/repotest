import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { CreatePlayerOrcDto } from './dto/createPlayerOrc.dto';
import { PlayersTokenDto } from '../token/dto/token.dto';

@Injectable()
export class OrcService {
  constructor(private prismaService: PrismaService) {}

  async createOrUpdatePlayerOrc(
    dto: CreatePlayerOrcDto,
    currentUser: PlayersTokenDto,
  ) {
    const candidate = await this.prismaService.playersOrcs.findFirst({
      where: { playerId: currentUser.id },
    });
    if (candidate) {
      if (candidate.hp === 0) {
        await this.prismaService.playersOrcs.update({
          where: { id: candidate.id },
          data: {
            hp: 0,
            lastBossDate: new Date(Date.now()),
            bossStreak: { increment: 1 },
          },
        });
        return { message: 'Player orc updated' };
      }
      await this.prismaService.playersOrcs.update({
        where: { id: candidate.id },
        data: { hp: { decrement: dto.hp } },
      });

      return { message: 'Player orc updated' };
    }
    const playerOrc = await this.prismaService.playersOrcs.create({
      data: {
        hp: dto.hp,
        bossStreak: dto.bossStreak,
        playerId: currentUser.id,
      },
    });

    return playerOrc;
  }
}
