import { Module } from '@nestjs/common';
import { WorkspaceController } from './workspace.controller';
import { WorkspaceService } from './workspace.service';
import { PrismaModule } from '../prisma/prisma.module';
import { WorkspaceRepository } from './repositories/workspace.repository';
import { WORKSPACE_REPOSITORY } from './repositories/workspace.repository.interface';

@Module({
  imports: [PrismaModule],
  controllers: [WorkspaceController],
  providers: [
    WorkspaceService,
    {
      provide: WORKSPACE_REPOSITORY,
      useClass: WorkspaceRepository,
    },
  ],
  exports: [WORKSPACE_REPOSITORY],
})
export class WorkspaceModule {}
