import { $Enums, Media } from '@prisma/client';
import { ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';

export class MediaType implements Media {
  @ApiProperty({
    description: 'Unique identifier for the media',
    example: 'f9d8d2b7-4f40-4f5e-a0e2-f13e7e0f0c54',
  })
  id: string;

  @ApiProperty({
    description: 'The name of the media file',
    example: 'telegram_icon.png',
  })
  fileName: string;

  @ApiProperty({
    description: 'The path where the media file is stored',
    example: '/public/media/telegram_icon.png',
  })
  filePath: string;

  @ApiProperty({
    description: 'Type of the media file (e.g., IMAGE, VIDEO)',
    example: 'IMAGE',
    enum: $Enums.FileType,
  })
  fileType: $Enums.FileType;

  @ApiProperty({
    description: 'The original name of the media file',
    example: 'telegram_icon.png',
  })
  originalName: string;

  @ApiProperty({
    description: 'MIME type of the media file',
    example: 'image/png',
  })
  mimeType: string;

  @Exclude()
  questId: string;

  @Exclude()
  createdAt: Date;

  @ApiProperty({
    description: 'Size of the media file in bytes',
    example: '123456',
  })
  size: string;

  @Exclude()
  updatedAt: Date;
}
