import { Module } from '@nestjs/common';
import { CiphersService } from './ciphers.service';
import { CiphersController } from './ciphers.controller';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { ProfitCommonModule } from '../profitCommon/profitCommon.module';

@Module({
    imports: [ProfitCommonModule],
    controllers: [CiphersController],
    providers: [CiphersService],
})
export class CiphersModule {}
