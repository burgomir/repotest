import { PrismaClient } from '@prisma/client';
import { ConfigService } from '@nestjs/config';
import { readFileSync, writeFileSync, existsSync, unlinkSync } from 'fs';
import { join } from 'path';

const prisma = new PrismaClient();
const configService = new ConfigService();

console.log('Seeding...');
const startTime = new Date();

async function main() {
  const players = await prisma.players.findMany({
    where: { referredById: { not: null } },
    select: { id: true, referredById: true, balance: true },
  });

  for (const player of players) {
    console.log('🚀 ~ main ~ player:', player);

    const referredPlayerExists = await prisma.players.findUnique({
      where: { id: player.referredById },
    });

    if (!referredPlayerExists) {
      console.log(`Player with id ${player.referredById} does not exist`);
      continue;
    }

    const referralProfit = await prisma.referralsProfit.findUnique({
      where: { playerId: player.referredById },
    });

    if (referralProfit) {
      await prisma.referralsProfit.update({
        data: { honey: { increment: player.balance * 0.05 } },
        where: { playerId: player.referredById },
      });
    } else {
      await prisma.referralsProfit.create({
        data: { honey: player.balance * 0.05, playerId: player.referredById },
      });
    }
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
    const endTime = new Date();
    const timeDiff = (endTime.getTime() - startTime.getTime()) / 1000;
    console.log(`Seeding finished. Time taken: ${timeDiff} seconds`);
  });
