import { Injectable } from '@nestjs/common';
import { Socket } from 'socket.io';
import { TokenService } from '../token/token.service';
import { PrismaService } from 'src/utils/prisma/prisma.service';
import { WsException } from '@nestjs/websockets';

@Injectable()
export class SocketsService {
  constructor(
    private readonly tokenService: TokenService,
    private prismaService: PrismaService,
  ) {}

  async checkToken(client: Socket) {
    const authToken = client.handshake.auth.token;
    const authHeader = client.handshake.headers.authorization;
    if (authToken && authHeader) {
      client.disconnect();
      throw new WsException('User unauthorized');
    }
    try {
      if (authToken) {
        const decodedToken = this.tokenService.validateAccessToken(authToken);
        if (!decodedToken) {
          client.disconnect();
          return;
        }

        client.user = decodedToken;

        const user = await this.prismaService.players.findUnique({
          where: { id: decodedToken.id },
        });
        if (!user) {
          client.disconnect();
          throw new WsException('User unauthorized');
        }
        client.user = decodedToken;
      } else {
        const token = authHeader.split(' ')[1];
        const decodedToken = this.tokenService.validateAccessToken(token);
        if (!decodedToken) {
          client.disconnect();
          return;
        }

        client.user = decodedToken;

        const user = await this.prismaService.players.findUnique({
          where: { id: decodedToken.id },
        });
        if (!user) {
          client.disconnect();
          throw new WsException('User unauthorized');
        }
        client.user = decodedToken;
      }
    } catch (error) {
      console.log(error);
      client.disconnect();
      return;
    }
  }
}
