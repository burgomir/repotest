import {
  WebSocketGateway,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
} from '@nestjs/websockets';
import { Logger, UseFilters } from '@nestjs/common';
import { Server, Socket } from 'socket.io';
import { WsExceptionsFilter } from 'src/utils/core/webSocketException.filter';
import { BalanceService } from '../../balance/balance.service';
import { SocketsService } from '../socket.service';

const allowedOrigins = [
  'https://beeverse.zapto.org',
  'http://beeverse.zapto.org'
];

// @UseGuards(WebSocketAuthGuard)
@UseFilters(WsExceptionsFilter)
@WebSocketGateway({
  cors: {
    origin: (origin, callback) => {
      if (!origin || allowedOrigins.includes(origin)) {
        callback(null, true);
      } else {
        callback(new Error('Not allowed by CORS'));
      }
    },
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS',
    allowedHeaders: 'Content-Type,Authorization',
    credentials: true,
  },
  namespace: 'backend/balance',
  transports: ['websocket', 'polling'],
})
export class BalanceGateway
  implements OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer()
  server: Server;

  private readonly logger = new Logger(BalanceGateway.name);

  constructor(
    private readonly balanceService: BalanceService,
    private readonly socketService: SocketsService,
  ) {}

  async handleConnection(client: Socket) {
    await this.socketService.checkToken(client);
    this.logger.log(`Client connected: ${client.id}`);
  }

  async handleDisconnect(client: Socket) {
    this.logger.log(`Client disconnected: ${client.id}`);
  }

  @SubscribeMessage('updateBalance')
  async handleUpdateBalance(
    @ConnectedSocket() client: Socket,
    @MessageBody() payload: { amount: number },
  ) {
    const userId = client.user.id;
    await this.balanceService.updateBalance(userId, payload.amount);
    const newBalance = await this.balanceService.getPlayerBalance(userId);
    const cachedBalance = await this.balanceService.getBalance(userId);
    const totalBalance = newBalance + cachedBalance;
    const bossHp = await this.balanceService.getBossHp(userId);
    client.emit('balanceUpdated', { balance: newBalance, bossHp });
    this.logger.log(`Balance updated for user ${userId}: ${totalBalance}`);
  }
}
