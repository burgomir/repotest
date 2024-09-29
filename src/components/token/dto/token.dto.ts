import { Players } from '@prisma/client';

export class PlayersTokenDto {
  id?: string;
  userName?: string;
  tgId?: string;
  referredById?: string;
  initData?: string;

  constructor(entity) {
    this.id = entity.id;
    this.userName = entity.userName;
    this.tgId = entity.tgId;
    this.referredById = entity.referredById;
    this.initData = entity.initData;
  }
}
