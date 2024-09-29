import { Controller, Get, Query } from '@nestjs/common';
import { LoggerService } from './logger.service';
import { FindLogsFilter } from './dto/logs.dto';
import {
  ApiBearerAuth,
  ApiOkResponse,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';

@ApiTags('logs')
@Controller('/root/logs')
export class LoggerController {
  constructor(private readonly loggerService: LoggerService) {}
}
