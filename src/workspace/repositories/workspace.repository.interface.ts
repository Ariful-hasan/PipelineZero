import { IBaseRepository } from '../../core/repositories/base.repository.interface';
import { Workspace, Prisma } from '@prisma/client';
import { UpdateWorkspaceDto } from '../dto/update.workspace.dto';

export type IWorkspaceRepository = IBaseRepository<
  Workspace,
  Prisma.WorkspaceCreateInput,
  UpdateWorkspaceDto
>;

export const WORKSPACE_REPOSITORY = Symbol('IWorkspaceRepository');
