import { FileType, PrismaClient } from '@prisma/client';
import { MinioService } from '../../libs/minio/minio.service';
import { ConfigService } from '@nestjs/config';
import { createReadStream, ReadStream } from 'fs';
import { join } from 'path';
import { ImageTransformer } from '../../common/pipes/imageTransform.pipe';

const prisma = new PrismaClient();
const configService = new ConfigService();
const minioService = new MinioService(configService);
const imageTransformer = new ImageTransformer(minioService, false);

console.log('Seeding...');
const startTime = new Date();

const bonusAmount = [0, 50000, 100000, 150000, 250000, 500000];
const requiredAmount = [0, 100000, 500000, 1000000, 3000000, 10000000];
const description = [
  '0 rang',
  'Reward: Improved Boots in the future update + 50,000',
  'Reward: Improved Gauntlets in the future update + 100,000',
  'Reward: Improved Cuirass in the future update + 150,000',
  'Reward: Improved Headgear in the future update + 250,000',
  'Reward: Improved Weapon in the future update + 500,000',
];
const rankNames = ['R0', 'R1', 'R2', 'R3', 'R4', 'R5'];

const referralRequiredAmount = [1, 3, 5, 10, 25, 50];
const referralQuestReward = [50000, 75000, 100000, 150000, 200000, 250000];
const referralQuestDescription = [
  'LVL 1 - Invite your friend! To complete this quest, your friend must be your referral.',
  'LVL 2 - Invite 3 your friends! To complete this quest, your friends must be your referrals.',
  'LVL 3 - Invite 5 your friends! To complete this quest, your friends must be your referrals.',
  'LVL 4 - Invite 10 your friends! To complete this quest, your friends must be your referrals.',
  'LVL 5 - Invite 25 your friends! To complete this quest, your friends must be your referrals.',
  'LVL 6 - Invite 50 your friends! To complete this quest, your friends must be your referrals.',
];

const questIcons = [
  join(__dirname, '../../../public/telegram_icon.png'),
  join(__dirname, '../../../public/telegram_icon.png'),
  join(__dirname, '../../../public/x_icon.png'),
];
const questDescription = [
  'Subscribe to us, react to our posts, leave comments! (English only) You need to wait 24 hours for this quest to be counted. If you unsubscribe - it will fail!',
  'Subscribe to us and chat with us! (English only) You need to wait 24 hours for this quest to be counted. If you unsubscribe, it will fail!',
  'Follow us, like our tweets, leave comments! (English only) You need to wait 24 hours for this quest to be counted. If you unfollow - it will fail!',
];
const questLinks = [
  ' https://t.me/nctr_ann',
  'https://t.me/nctr_group',
  'https://x.com/beeversedao',
];
const questRewards = [50000, 50000, 50000];
const questTerms = [
  'Join our Telegram channel!',
  'Join our Telegram chat!',
  'Join our Twitter!',
];

async function main() {
  await prisma.ranks.deleteMany();
  const quests = await prisma.quests.findMany({ include: { media: true } });
  for (const quest of quests) {
    await minioService.deleteFile(quest.media.fileName);
    await prisma.quests.delete({ where: { id: quest.id } });
  }
  await prisma.media.deleteMany();
  await prisma.referralsQuest.deleteMany();
  for (let i = 0; i < rankNames.length; i++) {
    await prisma.ranks.create({
      data: {
        bonusAmount: bonusAmount[i],
        requiredAmount: requiredAmount[i],
        description: description[i],
        name: rankNames[i],
        rank: i,
      },
    });
  }

  for (let i = 0; i < questLinks.length; i++) {
    const iconFile = {
      fieldname: `icon${i}`,
      originalname: `icon${i}.png`,
      encoding: '7bit',
      mimetype: 'image/png',
      destination: 'path/to/destination',
      filename: `icon${i}.png`,
      path: questIcons[i],
      size: 0,
      stream: createReadStream(questIcons[i]) as unknown as ReadStream,
      buffer: Buffer.alloc(0),
    };
    const imageTransformerForPublicFiles = new ImageTransformer(
      minioService,
      true,
    );
    const transformedIcon =
      await imageTransformerForPublicFiles.transform(iconFile);

    const quest = await prisma.quests.create({
      data: {
        link: questLinks[i],
        reward: questRewards[i],
        terms: questTerms[i],
        description: questDescription[i],
      },
    });

    await prisma.media.create({
      data: {
        fileName: transformedIcon.fileName,
        filePath: transformedIcon.filePath,
        size: transformedIcon.size,
        mimeType: transformedIcon.mimeType,
        originalName: transformedIcon.originalName,
        fileType: FileType.IMAGE,
        questId: quest.id,
      },
    });
  }

  for (let i = 0; i < referralQuestReward.length; i++) {
    await prisma.referralsQuest.create({
      data: {
        referralCount: referralRequiredAmount[i],
        level: i + 1,
        reward: referralQuestReward[i],
        description: referralQuestDescription[i],
      },
    });
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
