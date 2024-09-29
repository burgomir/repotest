import { Injectable, NotFoundException, Logger } from '@nestjs/common';
import { MinioService } from '../../libs/minio/minio.service';
import { ITransformedFile } from '../../common/interfaces/fileTransform.interface';
import { PrismaService } from 'src/utils/prisma/prisma.service';

@Injectable()
export class MediaService {
  private readonly logger = new Logger(MediaService.name);

  constructor(
    private minioService: MinioService,
    private readonly prisma: PrismaService,
  ) {}

  async createFilesMedia(
    files: ITransformedFile[],
    entityId: string,
    entityColumn: string,
  ) {
    const mediaIds = [];

    for (const file of files) {
      const mediaData: any = {
        originalName: file.originalName,
        fileName: file.fileName,
        filePath: file.filePath,
        mimeType: file.mimeType,
        size: file.size,
        fileType: file.fileType,
      };
      mediaData[entityColumn] = entityId;

      const media = await this.prisma.media.create({
        data: mediaData,
      });

      mediaIds.push(media.id);
    }

    return mediaIds;
  }

  async createFileMedia(
    file: ITransformedFile,
    entityId: string,
    entityColumn: string,
  ) {
    const mediaData: any = {
      originalName: file.originalName,
      fileName: file.fileName,
      filePath: file.filePath,
      mimeType: file.mimeType,
      size: file.size,

      fileType: file.fileType,
    };
    mediaData[entityColumn] = entityId;

    const media = await this.prisma.media.create({
      data: mediaData,
    });

    return media.id;
  }

  async deleteMedias(fileIds: string[]) {
    this.logger.log(`Удаление медиа с идентификаторами: ${fileIds.join(', ')}`);
    const files = await this.prisma.media.findMany({
      where: { id: { in: fileIds } },
    });
    if (!files.length) {
      this.logger.warn('Некоторые файлы не найдены!');
      throw new NotFoundException('Some files are not found!');
    }
    const fileNames = files.map((file) => file.fileName);
    await this.minioService.deleteFiles(fileNames);
    await this.prisma.media.deleteMany({
      where: { id: { in: fileIds } },
    });
  }

  async deleteOneMedia(mediaId: string) {
    this.logger.log(`Удаление медиа с идентификатором: ${mediaId}`);
    const file = await this.prisma.media.findUnique({
      where: { id: mediaId },
    });
    if (!file) {
      this.logger.warn(`Медиа с идентификатором ${mediaId} не найдено!`);
      throw new NotFoundException('Media not found!');
    }
    await this.minioService.deleteFile(file.fileName);
    await this.prisma.media.delete({
      where: { id: mediaId },
    });
  }

  async getOneMedia(mediaId: string) {
    this.logger.log(`Получение медиа с идентификатором: ${mediaId}`);
    const media = await this.prisma.media.findUnique({
      where: { id: mediaId },
    });
    if (!media) {
      this.logger.warn(`Медиа с идентификатором ${mediaId} не найдено!`);
      throw new NotFoundException('Media not found!');
    }
    return media;
  }
}
