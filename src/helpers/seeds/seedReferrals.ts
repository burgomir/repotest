import { faker } from '@faker-js/faker';
import { PrismaClient } from '@prisma/client';
import axios from 'axios';

const prisma = new PrismaClient();

const user_tg_id = '7296153848';
const count_referals = 20;

console.log('Seeding...');
const startTime = new Date();

async function main() {
  for (let i = 1; i <= count_referals; i++) {
    const data = {
      tgId: faker.number.int(),
      isPremium: true,
      userName: faker.person.firstName(),
      nickName: faker.person.fullName(),
    };

    try {
      const response = await axios.post(
        `http://127.0.0.1:5005/api/auth/login?referrerId=${user_tg_id}`,
        data,
      );
      console.log('🚀 ~ main ~ response:', response);
      console.log(`Response for i${i}:`, response.data);
      await prisma.players.update({
        where: { id: response.data.player.id },
        data: {
          balance: {
            increment: faker.number.float(100000),
          },
        },
      });
    } catch (error: any) {
      console.error(`Error for i${i}:`, error.message);
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
