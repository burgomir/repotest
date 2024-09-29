import { Module } from '@nestjs/common';
import { LoggerService } from './logger.service';
import CustomLogger from './helpers/customLogger';
import { MongooseModule } from '@nestjs/mongoose';
import { Log, LogSchema } from './schema/logger.schema';

@Module({
  imports: [MongooseModule.forFeature([{ name: Log.name, schema: LogSchema }])],
  providers: [LoggerService, CustomLogger],
  exports: [CustomLogger],
})
export class LoggerModule {}
