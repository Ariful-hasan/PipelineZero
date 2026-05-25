import { Prisma } from '@prisma/client';

export type WorkspaceDetailsPayload = Prisma.WorkspaceGetPayload<{
  include: {
    users: {
      include: {
        user: true;
      };
    };
    // jobApplications: true;
    // invitations: true;
  };
}>;
