import { Injectable, Inject, NotFoundException } from '@nestjs/common';
import { WORKSPACE_REPOSITORY } from './repositories/workspace.repository.interface';
import type { IWorkspaceRepository } from './repositories/workspace.repository.interface';
import { CreateWorkspaceDto } from './dto/create-workspace.dto';
import { UtilService } from '../core/utils/util/util.service';
import { WorkspaceDetailsPayload } from './types/workspace-payload.types';

@Injectable()
export class WorkspaceService {
  constructor(
    @Inject(WORKSPACE_REPOSITORY)
    private readonly workspaceRepository: IWorkspaceRepository,
    private readonly utilService: UtilService,
  ) {}

  async findById(id: string): Promise<WorkspaceDetailsPayload> {
    const workspace = await this.workspaceRepository.findById(id);

    if (!workspace) {
      throw new NotFoundException('Workspace not found');
    }

    return workspace;
  }

  async findAll(params?: {
    skip?: number;
    take?: number;
    where?: any;
    orderBy?: any;
  }) {
    return this.workspaceRepository.findAll(params);
  }

  async create(data: CreateWorkspaceDto, userId: string) {
    if (!userId) {
      throw new Error('User ID is required to create a workspace');
    }

    const slug = this.utilService.generateSlug(data.name, userId);
    const createPayload = {
      ...data,
      slug,
      isActive: true,
    };

    return await this.workspaceRepository.create(createPayload, userId);
  }

  async update(id: string, data: any) {
    return this.workspaceRepository.update(id, data);
  }

  async delete(id: string) {
    return this.workspaceRepository.delete(id);
  }
}
