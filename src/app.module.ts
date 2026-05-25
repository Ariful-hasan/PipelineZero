import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { HealthModule } from './health/health.module';
import { AuthModule } from './auth/auth.module';
import { WorkspaceModule } from './workspace/workspace.module';
import { CoreModule } from './core/core.module';
import { UserModule } from './user/user.module';

@Module({
  imports: [
    PrismaModule,
    HealthModule,
    AuthModule,
    WorkspaceModule,
    CoreModule,
    UserModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
