import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Log, LogDocument } from './schema/logger.schema';

@Injectable()
export class LoggerService {
  constructor(@InjectModel(Log.name) private logModel: Model<LogDocument>) {}

  async createLog(logData: Partial<Log>): Promise<Log> {
    const createdLog = new this.logModel(logData);
    return createdLog.save();
  }

  async findAll(): Promise<Log[]> {
    return this.logModel.find().exec();
  }
}
