import { Controller } from '@nestjs/common';
import { OrcService } from './orc.service';

@Controller('orc')
export class OrcController {
  constructor(private readonly orcService: OrcService) {}
}
