/*
  Warnings:

  - The `role` column on the `workspace_users` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Changed the type of `role` on the `workspace_invitations` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "WorkspaceRole" AS ENUM ('OWNER', 'ADMIN', 'MEMBER', 'VIEWER');

-- AlterTable
ALTER TABLE "workspace_invitations" DROP COLUMN "role",
ADD COLUMN     "role" "WorkspaceRole" NOT NULL;

-- AlterTable
ALTER TABLE "workspace_users" DROP COLUMN "role",
ADD COLUMN     "role" "WorkspaceRole" NOT NULL DEFAULT 'MEMBER';
