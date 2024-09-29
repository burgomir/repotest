import {
    Controller,
    Get,
    Post,
    Body,
} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { CiphersService } from './ciphers.service';
import { ConfirmCipherDto } from './dto/confirmCipher.dto';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { CurrentUser } from 'src/common/decorators/currentUser.decorator';
import { AvailableCipherResponse, ConfirmCipherResponse } from './responses/confirmCipher.response';
import { ConfirmCipherOperation } from './decorators/confirmCipherOperation.decorator';
import { AvailableCipherOperation } from './decorators/availableCipherOperation.decorator';

@ApiTags('ciphers')
@Controller('cipher')
export class CiphersController {
    constructor(private readonly ciphersService: CiphersService) { }

    @Get('available')
    @AvailableCipherOperation()
    async isCipherAvailable(
        @CurrentUser() currentUser: PlayersTokenDto
    ): Promise<AvailableCipherResponse[]> {
        const available = await this.ciphersService.isCipherAvailable(currentUser);
        return available;
    }

    @Post('confirm')
    @ConfirmCipherOperation()
    async confirmCipher(
        @Body() dto: ConfirmCipherDto,
        @CurrentUser() currentUser: PlayersTokenDto,
    ): Promise<ConfirmCipherResponse> {
        console.log(currentUser)
        return await this.ciphersService.confirmCipher(dto, currentUser);
    }
}

