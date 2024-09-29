import { ReferralEarlyBonuses } from 'src/helpers/dto/referralEarlyBonuses.dto';
import { PickType } from '@nestjs/swagger';

export class CreateNewReferralBonusDto extends PickType(ReferralEarlyBonuses, [
  'honey',
  'accountType',
] as const) {}
