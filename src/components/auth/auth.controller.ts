import { Body, Controller, Get, HttpCode, Post, Query } from '@nestjs/common';
import { AuthService } from './auth.service';
import { PlayerLogoutOperation } from './decorators/playerLogout.decorator';
import { Cookies } from 'src/common/decorators/getCookie.decorator';
import { PlayerRefreshOperation } from './decorators/playerRefreshOperation.decorator';
import { PlayerLoginOperation } from './decorators/playerLoginOperation.decorator';
import { ApiTags } from '@nestjs/swagger';
import { PlayerLoginDto } from './dto/userLogin.dto';
import { PlayerRefreshResponse } from './responses/playerRefresh.response';
import { Public } from 'src/common/decorators/isPublic.decorator';
import { PlayerLoginResponse } from './responses/playerLogin.response';
import { SuccessMessageType } from 'src/helpers/common/successMessage.type';

@ApiTags('auth')
@Public()
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @PlayerLoginOperation()
  @HttpCode(200)
  @Post('login')
  async login(
    @Body() dto: PlayerLoginDto,
    @Query('referrerId') referrerId?: string,
  ): Promise<PlayerLoginResponse> {
    return await this.authService.registerOrLogin(dto, referrerId);
  }

  @PlayerLogoutOperation()
  @HttpCode(200)
  @Post('logout')
  async logout(
    @Cookies('refreshToken') refreshToken: string,
  ): Promise<SuccessMessageType> {
    const { message } = await this.authService.logoutPlayer(refreshToken);

    return { message };
  }

  @PlayerRefreshOperation()
  @Get('refresh')
  async refresh(
    @Cookies('refreshToken') requestRefreshToken: string,
  ): Promise<PlayerRefreshResponse> {
    const { message, player, accessToken, refreshToken } =
      await this.authService.refreshTokens(requestRefreshToken);

    return {
      message,
      player,
      accessToken,
      refreshToken,
    };
  }
}
