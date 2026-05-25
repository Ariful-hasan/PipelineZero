import { Controller, Get, ServiceUnavailableException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Controller('health')
export class HealthController {
  constructor(private readonly prismaService: PrismaService) {}

  @Get('ping')
  async ping(): Promise<{ status: string }> {
    try {
      await this.prismaService.$queryRaw`SELECT 1`;
      return { status: 'ok' };
    } catch {
      throw new ServiceUnavailableException({
        status: 'error',
        message: 'Database connection failed',
      });
    }
  }
}
