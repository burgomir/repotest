import { ApiProperty } from '@nestjs/swagger';

export class ConfirmCipherResponse {
  @ApiProperty({ description: 'Indicates whether the operation was successful' })
  success: boolean;

  @ApiProperty({ description: 'The reward amount if available', required: false })
  reward?: number;

  @ApiProperty({ description: 'Optional message for additional information', required: false })
  message?: string;

  @ApiProperty({ description: 'Optional cipher link data'})
  link:         string;

  @ApiProperty({ description: 'Optional cipher title data'})
  title:        string;

  @ApiProperty({ description: 'Optional cipher description data'})
  description:  string;

  @ApiProperty({ description: 'Optional cipher image data'})
  image:        string;
}

export class AvailableCipherResponse {
  @ApiProperty({ description: 'Cipher exists' })
  exists: boolean;

  @ApiProperty({ description: 'The reward amount if available', required: false })
  reward?: number;

  @ApiProperty({ description: 'Optional message for additional information', required: false })
  message?: string;

  @ApiProperty({ description: 'Optional cipher link data'})
  link:         string;

  @ApiProperty({ description: 'Optional cipher title data'})
  title:        string;

  @ApiProperty({ description: 'Optional cipher description data'})
  description:  string;

  @ApiProperty({ description: 'Optional cipher image data'})
  image:        string;

  @ApiProperty({ description: 'Optional is cipher alredy used', required: false })
  is_used:      boolean;
}