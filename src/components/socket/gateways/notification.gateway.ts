import {
  WebSocketGateway,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
} from '@nestjs/websockets';
import { Logger, UseFilters, UseGuards } from '@nestjs/common';
import { Namespace, Socket } from 'socket.io';
import { WebSocketAuthGuard } from 'src/common/guards/wsAuth.guard';
import { WsExceptionsFilter } from 'src/utils/core/webSocketException.filter';
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
  namespace: 'backend/notification',
  transports: ['websocket', 'polling'],
})
export class NotificationGateway
  implements OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer()
  io: Namespace;

  private logger: Logger = new Logger('NotificationGateway');
  private clients: Map<string, string> = new Map();

  constructor(private socketService: SocketsService) {}

  async handleConnection(client: Socket) {
    await this.socketService.checkToken(client);
    const userId = client.user?.id as string;
    if (userId) {
      this.logger.log(`Client connected: ${client.id}`);
      this.clients.set(userId, client.id);
    }
  }

  handleDisconnect(client: Socket) {
    const userId = Array.from(this.clients.entries()).find(
      ([_, id]) => id === client.id,
    )?.[0];

    if (userId) {
      this.clients.delete(userId);
      this.logger.log(`Client disconnected: ${client.id}`);
    }
  }

  @SubscribeMessage('bossKill')
  handleBossKill(
    @ConnectedSocket() client: Socket,
    @MessageBody() payload: any,
  ) {
    this.logger.log(
      `Received bossKill event from ${client.id} with payload:`,
      payload,
    );
    const userId = client.user?.id as string;
    if (userId) {
      this.sendBossKillNotification(userId, payload.message);
    } else {
      this.logger.warn('Client sent bossKill event without user ID');
    }
  }

  async sendBossKillNotification(
    userId: string,
    message: string,
    bossStreak?: number,
    bossStreakHoney?: number,
    rewardRarity?: string, 
    rewardNctr?: number,
    rewardCrystal?: number
  ) {
    const socketId = this.clients.get(userId);
    if (socketId) {
      this.io
        .to(socketId)
        .emit('bossKill', { message, bossStreak, bossStreakHoney, rewardRarity, rewardNctr, rewardCrystal });
      this.logger.log(`Sent bossKill notification to ${socketId}: ${message}`);
    } else {
      this.logger.warn(`No client found for userId ${userId}`);
    }
  }

  @SubscribeMessage('rankLevelUp')
  handleRankLevelUp(
    @ConnectedSocket() client: Socket,
    @MessageBody() payload: any,
  ) {
    this.logger.log(
      `Received bossKill event from ${client.id} with payload:`,
      payload,
    );
    const userId = client.user?.id as string;
    if (userId) {
      this.sendRankLevelUpNotification(userId, payload.message);
    } else {
      this.logger.warn('Client sent bossKill event without user ID');
    }
  }

  async sendRankLevelUpNotification(
    userId: string,
    message: string,
    newRankLevel?: number,
    rankProfit?: number,
  ) {
    const socketId = this.clients.get(userId);
    if (socketId) {
      this.io
        .to(socketId)
        .emit('rankLevelUp', { message, newRankLevel, rankProfit });
      this.logger.log(`Rank level up notification to ${socketId}: ${message}`);
    } else {
      this.logger.warn(`No client found for userId ${userId}`);
    }
  }

  @SubscribeMessage('collectedTopReward')
  handleCollectedTopReward(
    @ConnectedSocket() client: Socket,
    @MessageBody() payload: any,
  ) {
    this.logger.log(
      `Received collectedTopReward event from ${client.id} with payload:`,
      payload,
    );
    const userId = client.user?.id as string;
    if (userId) {
      this.sendCollectedTopRewardNotification(userId, payload.message);
    } else {
      this.logger.warn('Client sent collectedTopReward event without user ID');
    }
  }

  async sendCollectedTopRewardNotification(
    userId: string,
    message: string,
    rewardRarity?: string,
    collectedNctr?: number,
    collectedCrystal?: number
  ) {
    const socketId = this.clients.get(userId);
    if (socketId) {
      this.io
        .to(socketId)
        .emit('collectedTopReward', { message, rewardRarity, collectedNctr, collectedCrystal });
      this.logger.log(`Sent collectedTopReward notification to ${socketId}: ${message}`);
    } else {
      this.logger.warn(`No client found for userId ${userId}`);
    }
  }
}
