import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { ConfirmCipherDto } from './dto/confirmCipher.dto';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { ProfitCommonService } from '../profitCommon/profitCommon.service';
import { AvailableCipherResponse, ConfirmCipherResponse } from './responses/confirmCipher.response';

@Injectable()
export class CiphersService {
    constructor(
        private prismaService: PrismaService,
        private profitCommonService: ProfitCommonService,
    ) { }

    async isCipherAvailable(currentUser: PlayersTokenDto): Promise<AvailableCipherResponse[]> {
        const now = new Date();
        const ciphers = await this.prismaService.cipher.findMany({
            where: {
                startDate: { lte: now },
                endDate: { gte: now },
                OR: [
                    { totalLimit: null },
                    { totalLimit: { gt: 0 } },
                ],
            },
            orderBy: { startDate: 'asc' },
        });

        console.log(currentUser)
    
        if (!ciphers || ciphers.length === 0) {
            throw new NotFoundException('No ciphers found');
        }
    
        const player = await this.prismaService.players.findFirst({
            where: {
                id: currentUser.id,
            },
        });
    
        if (!player) {
            throw new NotFoundException('User not found');
        }
    
        const cipherResponses: AvailableCipherResponse[] = [];
    
        for (const cipher of ciphers) {
            const existingUsage = !!(await this.prismaService.playersCiphers.findUnique({
                where: {
                    playerId_cipherId: {
                        playerId: currentUser.id,
                        cipherId: cipher.id,
                    },
                },
            }));
    
            cipherResponses.push({
                exists: true,
                reward: cipher.reward,
                link: cipher.link,
                title: cipher.title,
                description: cipher.description,
                image: cipher.image,
                is_used: existingUsage,
            });
        }
    
        return cipherResponses;
    }
    

    async confirmCipher(
        dto: ConfirmCipherDto,
        currentUser: PlayersTokenDto,
    ): Promise<ConfirmCipherResponse> {
        const now = new Date();
        const cipher = await this.prismaService.cipher.findFirst({
            where: {
                cipher: dto.cipher,
                startDate: { lte: now },
                endDate: { gte: now },
                OR: [
                    { totalLimit: null },
                    { totalLimit: { gt: 0 } },
                ],
            },
        });

        if (!cipher) {
            throw new BadRequestException('Неверная или истекшая секретная фраза');
        }

        const player = await this.prismaService.players.findFirst({
            where: {
                id: currentUser.id
            }
        })

        if (!player) {
            throw new BadRequestException('Пользователь не найден')
        }

        const existingUsage = await this.prismaService.playersCiphers.findUnique({
            where: {
                playerId_cipherId: {
                    playerId: currentUser.id,
                    cipherId: cipher.id,
                },
            },
        });

        if (existingUsage) {
            throw new BadRequestException('Вы уже использовали этот шифр');
        }

        if (cipher.totalLimit !== null && cipher.currentUsage >= cipher.totalLimit) {
            throw new BadRequestException('Лимит использования шифра достигнут');
        }

        await this.prismaService.$transaction(async (prisma) => {
            await prisma.cipher.update({
                where: { id: cipher.id },
                data: { currentUsage: { increment: 1 } },
            });

            await prisma.playersCiphers.create({
                data: {
                    playerId: currentUser.id,
                    cipherId: cipher.id,
                    usedAt: now,
                },
            });

            await prisma.players.update({
                where: { id: currentUser.id },
                data: { balance: { increment: cipher.reward } },
            });
        });

        await this.profitCommonService.calculateProfit(player.id, cipher.reward);

        return { success: true, reward: cipher.reward, link: cipher.link, title: cipher.title, description: cipher.description, image: cipher.image };
    }
}
