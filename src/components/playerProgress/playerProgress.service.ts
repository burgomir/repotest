import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { PlayerProgressDto } from './dto/progress.dto';

@Injectable()
export class PlayerProgressService {
  constructor(private prismaService: PrismaService) {}

  async createProgressOrUpdate(dto: PlayerProgressDto, playerId: string) {
    if (dto.progress === 0) return;

    const progress = await this.prismaService.playerProgress.findFirst({
      where: { playerId, type: dto.type },
    });

    if (!progress) {
      const playerProgress = await this.prismaService.playerProgress.create({
        data: { ...dto, playerId },
      });

      return { playerProgress };
    }

    const playerProgress = await this.prismaService.playerProgress.update({
      where: { id: progress.id },
      data: { progress: { increment: dto.progress } },
    });

    return { playerProgress };
  }
}
