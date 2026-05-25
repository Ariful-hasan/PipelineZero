import { Workspace, Prisma } from '@prisma/client';
import { UpdateWorkspaceDto } from '../dto/update.workspace.dto';
import { WorkspaceDetailsPayload } from '../types/workspace-payload.types';

export interface IWorkspaceRepository {
  findById(id: string): Promise<WorkspaceDetailsPayload | null>;
  findAll(params?: any): Promise<Workspace[]>;
  create(data: Prisma.WorkspaceCreateInput, userId: string): Promise<Workspace>;
  update(id: string, data: UpdateWorkspaceDto): Promise<Workspace>;
  delete(id: string): Promise<Workspace>;
  count(where?: any): Promise<number>;
}

export const WORKSPACE_REPOSITORY = Symbol('IWorkspaceRepository');
