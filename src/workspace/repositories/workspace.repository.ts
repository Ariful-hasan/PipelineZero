import { Injectable } from '@nestjs/common';
import { Workspace, Prisma } from '@prisma/client';
import { PrismaService } from '../../prisma/prisma.service';
import { IWorkspaceRepository } from './workspace.repository.interface';
import { UpdateWorkspaceDto } from '../dto/update.workspace.dto';

@Injectable()
export class WorkspaceRepository implements IWorkspaceRepository {
  constructor(private readonly prismaService: PrismaService) {}

  async findById(id: string): Promise<Workspace | null> {
    return this.prismaService.workspace.findUnique({ where: { id } });
  }

  async findAll(params?: {
    skip?: number;
    take?: number;
    where?: Prisma.WorkspaceWhereInput;
    orderBy?: Prisma.WorkspaceOrderByWithRelationInput;
  }): Promise<Workspace[]> {
    return this.prismaService.workspace.findMany({
      skip: params?.skip,
      take: params?.take ?? 20,
      where: params?.where,
      orderBy: params?.orderBy,
    });
  }

  async create(
    data: Prisma.WorkspaceCreateInput,
    userId: string,
  ): Promise<Workspace> {
    return this.prismaService.$transaction(async (tx) => {
      const workspace = await tx.workspace.create({
        data,
      });

      await tx.workspaceUser.create({
        data: {
          workspaceId: workspace.id,
          userId,
          role: 'OWNER',
        },
      });

      return workspace;
    });
  }

  async update(id: string, data: UpdateWorkspaceDto): Promise<Workspace> {
    return this.prismaService.$transaction(async (tx) => {
      return tx.workspace.update({
        where: { id },
        data,
      });
    });
  }

  async delete(id: string): Promise<Workspace> {
    return this.prismaService.$transaction(async (tx) => {
      return tx.workspace.delete({ where: { id } });
    });
  }

  async count(where?: Prisma.WorkspaceCountArgs['where']): Promise<number> {
    return this.prismaService.$transaction(async (tx) => {
      return tx.workspace.count({ where });
    });
  }
}
