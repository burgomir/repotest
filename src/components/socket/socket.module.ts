import { Module } from '@nestjs/common';
import { TokenModule } from 'src/components/token/token.module';
import { SocketsService } from './socket.service';
import { NotificationGateway } from './gateways/notification.gateway';
import { BalanceModule } from '../balance/balance.module';
import { BalanceGateway } from './gateways/balance.gateway';

@Module({
  imports: [TokenModule, BalanceModule],
  providers: [NotificationGateway, SocketsService, BalanceGateway],
  exports: [NotificationGateway, SocketsService, BalanceGateway],
})
export class SocketModule {}
