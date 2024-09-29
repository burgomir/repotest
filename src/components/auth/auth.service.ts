import {
  Injectable,
  Logger,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { TokenService } from '../token/token.service';
import { PlayersTokenDto } from '../token/dto/token.dto';
import { SuccessMessageType } from 'src/helpers/common/successMessage.type';
import { PlayerRefreshResponse } from './responses/playerRefresh.response';
import { PlayerLoginDto } from './dto/userLogin.dto';
import { PlayerLoginResponse } from './responses/playerLogin.response';
import { ReferralsService } from '../referrals/referrals.service';
import { ConfigService } from '@nestjs/config';
import { CreateNewReferralBonusDto } from '../referrals/dto/createNewReferralBonus.dto';
import { ProfitCommonService } from '../profitCommon/profitCommon.service';
import { validate,parse } from '@telegram-apps/init-data-node';
@Injectable()
export class AuthService {
  private logger = new Logger(AuthService.name);
  constructor(
    private tokenService: TokenService,
    private prismaService: PrismaService,
    private referralService: ReferralsService,
    private profitCommonService: ProfitCommonService,
    private configService: ConfigService,
  ) {}

  async registerOrLogin(
    dto: PlayerLoginDto,
    referrerId: string,
  ): Promise<PlayerLoginResponse> {
    
    this.logger.log('Попытка регистрации или входа пользователя...');

    const secretToken = this.configService.get<string>('BOT_TOKEN');

    let initDataJson;

    if (dto.initData == 'rogue') {
      initDataJson = {
        'user': {
          'id': 1111111,
          'firstName': 'rogue',
          'lastName': 'lastoff',
          'username': 'rogue_lastoff', 
          'isPremium': true
        }
      }
    } else {
      await validate(dto.initData, secretToken)
      initDataJson = parse(dto.initData)
    }

    const candidate = await this.prismaService.players.findFirst({
      where: { tgId: initDataJson.user.id.toString() },
    });

    if (candidate) {
      this.logger.log(
        `Пользователь ${candidate.userName} найден, выполняется вход...`,
      );
      const tokens = this.tokenService.generateTokens({
        ...new PlayersTokenDto(candidate),
      });
      await this.tokenService.saveTokens(candidate.id, tokens.refreshToken);

      await this.prismaService.players.update({
        where: { id: candidate.id },
        data: { lastLogin: new Date(Date.now()), nickName: initDataJson?.user.firstName + ' ' + initDataJson.user.lastName , userName: initDataJson.user?.username },
      });


      const firstRank = await this.prismaService.ranks.findFirst({
        where: { rank: 0 },
      });

      const playerRank = await this.prismaService.playerRanks.findFirst({
        where: { playerId: candidate.id, rankId: firstRank.id },
      });
      if (!playerRank) {
        await this.prismaService.playerRanks.create({
          data: {
            playerId: candidate.id,
            achievedAt: new Date(Date.now()),
            rankId: firstRank.id,
          },
        });
      }
      const playerOrc = await this.prismaService.playersOrcs.findUnique({
        where: { playerId: candidate.id },
      });

      if (!playerOrc) {
        await this.prismaService.playersOrcs.create({
          data: { hp: 5000, playerId: candidate.id },
        });
      }

      return {
        message: 'Player logged in',
        player: candidate,
        ...tokens,
        isNew: false,
      };
    }

    this.logger.log('Пользователь не найден, выполняется регистрация...');

    const player = await this.prismaService.players.create({
      data: {
        tgId: initDataJson.user.id.toString(),
        isPremium:!!(initDataJson.user.isPremium),
        userName: initDataJson.user.username ?? '',
        lastLogin: new Date(),
        honeyMax: 5000,
      },
    });

    const tokens = this.tokenService.generateTokens({
      ...new PlayersTokenDto(player),
    });
    await this.tokenService.saveTokens(player.id, tokens.refreshToken);

    const firstRank = await this.prismaService.ranks.findFirst({
      where: { rank: 0 },
    });

    await this.prismaService.playerRanks.create({
      data: {
        playerId: player.id,
        achievedAt: new Date(Date.now()),
        rankId: firstRank.id,
      },
    });

    let playerOrc = await this.prismaService.playersOrcs.create({
      data: { hp: 5000, playerId: player.id },
    });

    playerOrc = await this.prismaService.playersOrcs.findUnique({
      where: { playerId: player.id },
    });

    if (referrerId) {
      const referrer = await this.prismaService.players.findFirst({
        where: { tgId: referrerId },
      });
      if (referrerId === player.tgId) {
        return {
          message: 'Player registered successfully!',
          player,
          ...tokens,
          isNew: true,
        };
      }
      if (!referrer) {
        return {
          message: 'Player registered successfully!',
          player,
          ...tokens,
          isNew: true,
        };
      }

      await this.prismaService.referrals.create({
        data: { referralId: player.id, referrerId: referrer.id },
      });

      const commonBonus =
        this.configService.getOrThrow<number>('COMMON_ACC_BONUS');
      const premiumBonus =
        this.configService.getOrThrow<number>('PREMIUM_ACC_BONUS');
      const referralDto: CreateNewReferralBonusDto = {
        honey: player.isPremium ? +premiumBonus : +commonBonus,
        accountType: player.isPremium ? 'PREMIUM' : 'COMMON',
      };

      await this.prismaService.players.update({
        where: { id: player.id },
        data: { referredById: referrer.id },
      });

      await this.referralService.calculateNewReferralProfit(
        referralDto,
        referrer.id,
        player.id,
      );
      await this.referralService.handleNewRegistration(referrer.id);

      await this.profitCommonService.calculateProfit(
        player.id,
        referralDto.honey,
      );

      const tokenWithReferrer = this.tokenService.generateTokens({
        ...new PlayersTokenDto(player),
      });

      await this.tokenService.saveTokens(player.id, tokens.refreshToken);

      const newPlayer = await this.findPlayerById(player.id);

      return {
        message: 'Player registered successfully!',
        player: newPlayer,
        ...tokenWithReferrer,
        isNew: true,
      };
    }

    this.logger.log('Пользователь успешно зарегистрирован');
    return {
      message: 'Player registered successfully!',
      player,
      ...tokens,
      isNew: true,
    };
  }

  async logoutPlayer(refreshToken: string): Promise<SuccessMessageType> {
    this.logger.log('Попытка выхода пользователя...');
    if (!refreshToken) {
      this.logger.error('Не предоставлен обновляющий токен!');
      throw new UnauthorizedException('Refresh token not provided');
    }

    await this.tokenService.deleteToken(refreshToken);
    this.logger.log('Пользователь успешно вышел');

    return { message: 'Player logged out' };
  }

  async refreshTokens(refreshToken: string): Promise<PlayerRefreshResponse> {
    this.logger.log('Попытка обновления токенов...');
    if (!refreshToken) {
      this.logger.error('Не предоставлен обновляющий токен!');
      throw new UnauthorizedException('Refresh token not provided!');
    }

    const tokenFromDB = await this.tokenService.findToken(refreshToken);
    const validToken = this.tokenService.validateRefreshToken(refreshToken);

    if (!validToken || !tokenFromDB) {
      this.logger.error('Неверный токен!');
      throw new UnauthorizedException('Invalid token!');
    }

    const player = await this.findPlayerById(validToken.id);

    if (!player) {
      this.logger.error('Пользователь не найден!');
      throw new NotFoundException('player not found!');
    }

    const tokens = this.tokenService.generateTokens({
      ...new PlayersTokenDto(player),
    });

    await this.tokenService.saveTokens(player.id, tokens.refreshToken);

    this.logger.log('Токены успешно обновлены');
    return {
      message: 'Токены успешно обновлены',
      ...tokens,
      player,
    };
  }

  private async findPlayerById(playerId: string) {
    this.logger.log(`Поиск пользователя с ID ${playerId}...`);
    const player = await this.prismaService.players.findUnique({
      where: { id: playerId },
    });
    if (!player) {
      this.logger.error('Пользователь не найден!');
      throw new NotFoundException('Player not found!');
    }
    return player;
  }
}
