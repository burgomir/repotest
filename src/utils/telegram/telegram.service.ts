import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import axios from 'axios';

@Injectable()
export class TelegramService {
  private readonly botToken: string;
  private readonly telegramApiUrl: string;

  constructor(private configService: ConfigService) {
    this.botToken = this.configService.get<string>('BOT_TOKEN');
    this.telegramApiUrl = `https://api.telegram.org/bot${this.botToken}`;
  }

  async checkSubscription(userId: string, channelUsername: string): Promise<boolean> {
    try {
      const response = await axios.get(
        `${this.telegramApiUrl}/getChatMember`, 
        {
          params: {
            chat_id: `@${channelUsername}`,
            user_id: userId,
          },
        }
      );
      const { status } = response.data.result;
      return status === 'member' || status === 'administrator' || status === 'creator';
    } catch (error) {
      // throw new HttpException('Error checking subscription status', HttpStatus.BAD_REQUEST);
      return false;
    }
  }

  async sendMessage(userId: string, message: string): Promise<void> {
    try {
      await axios.post(`${this.telegramApiUrl}/sendMessage`, {
        chat_id: userId,
        text: message,
      });
    } catch (error) {
      throw new HttpException('Error sending message', HttpStatus.BAD_REQUEST);
    }
  }
}
