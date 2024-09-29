import { Injectable, Logger } from '@nestjs/common';
import { RedisRepository } from './redis.repository';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class RedisService {
  private readonly logger = new Logger(RedisService.name);

  constructor(private readonly redisRepository: RedisRepository) {}

  async get(prefix: string, key: string): Promise<string | null> {
    this.logger.log(`Getting value for key: ${prefix}:${key}`);
    return this.redisRepository.get(prefix, key);
  }

  async set(prefix: string, key: string, value: string): Promise<void> {
    this.logger.log(
      `Setting value for key: ${prefix}:${key} with value: ${value}`,
    );
    return this.redisRepository.set(prefix, key, value);
  }

  async delete(prefix: string, key: string): Promise<void> {
    this.logger.log(`Deleting key: ${prefix}:${key}`);
    return this.redisRepository.delete(prefix, key);
  }

  async setWithExpiry(
    prefix: string,
    key: string,
    value: string,
    expiry: number,
  ): Promise<void> {
    this.logger.log(
      `Setting value for key: ${prefix}:${key} with value: ${value} and expiry: ${expiry}`,
    );
    return this.redisRepository.setWithExpiry(prefix, key, value, expiry);
  }

  async getKeys(pattern: string): Promise<string[]> {
    this.logger.log(`Getting keys with pattern: ${pattern}`);
    return this.redisRepository.keys(pattern);
  }
}
