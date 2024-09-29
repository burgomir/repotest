import { IsString } from 'class-validator';

export class ConfirmCipherDto {
  @IsString()
  cipher: string;
}