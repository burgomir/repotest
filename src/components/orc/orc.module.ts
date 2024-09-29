import { Module } from '@nestjs/common';
import { OrcService } from './orc.service';
import { OrcController } from './orc.controller';

@Module({
  controllers: [OrcController],
  providers: [OrcService],
  exports: [OrcService],
})
export class OrcModule {}
