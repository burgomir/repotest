import { ReferralEarlyBonuses } from 'src/helpers/dto/referralEarlyBonuses.dto';
import { PickType } from '@nestjs/swagger';

export class CreateReferralEarlyBonusDto extends PickType(
  ReferralEarlyBonuses,
  ['honey'] as const,
) {}
