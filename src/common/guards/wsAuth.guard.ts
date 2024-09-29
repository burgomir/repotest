import {
  CanActivate,
  ExecutionContext,
  Injectable,
  Logger,
} from '@nestjs/common';
import { WsException } from '@nestjs/websockets';
import { Socket } from 'socket.io';
import { TokenService } from 'src/components/token/token.service';

declare module 'socket.io' {
  interface Socket {
    user?: any;
  }
}

@Injectable()
export class WebSocketAuthGuard implements CanActivate {
  private readonly logger = new Logger(WebSocketAuthGuard.name);

  constructor(private tokenService: TokenService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const client: Socket = context.switchToWs().getClient();
    const authToken = client.handshake.auth.token;
    this.logger.log('Authorization token:', authToken);

    if (!authToken) {
      this.logger.error('User unauthorized: No authorization token');
      client.disconnect();
      throw new WsException('User unauthorized');
    }

    try {
      const userToken = this.tokenService.validateAccessToken(authToken);
      this.logger.log('User token:', userToken);

      client.user = userToken;
      return true;
    } catch (e: any) {
      this.logger.error('User unauthorized', e.message);
      client.disconnect();
      throw new WsException('User unauthorized');
    }
  }
}
