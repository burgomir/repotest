import { IoAdapter } from '@nestjs/platform-socket.io';
import Redis from 'ioredis';
import { ServerOptions } from 'socket.io';
import { createAdapter } from '@socket.io/redis-adapter';

const pubClient = new Redis({
  host: process.env.REDIS_HOST,
  port: +process.env.REDIS_PORT,
});
const subClient = pubClient.duplicate();
const redisAdapter = createAdapter(pubClient, subClient);

export class RedisIoAdapter extends IoAdapter {
  createIOServer(port: number, options?: ServerOptions): any {
    const server = super.createIOServer(port, options);
    server.adapter(redisAdapter);
    return server;
  }
}
