/*
  Warnings:

  - The primary key for the `job_applications` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `deleted_at` on the `job_applications` table. All the data in the column will be lost.
  - You are about to drop the column `employment_type` on the `job_applications` table. All the data in the column will be lost.
  - You are about to drop the column `salary` on the `job_applications` table. All the data in the column will be lost.
  - You are about to drop the column `seniority_level` on the `job_applications` table. All the data in the column will be lost.
  - You are about to drop the column `source` on the `job_applications` table. All the data in the column will be lost.
  - The primary key for the `job_status_history` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `changed_at` on the `job_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `comment` on the `job_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `fromStatus` on the `job_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `job_id` on the `job_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `toStatus` on the `job_status_history` table. All the data in the column will be lost.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `phone` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `two_factor_enabled_at` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `two_factor_type` on the `users` table. All the data in the column will be lost.
  - The primary key for the `workspace_invitations` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `accepted_at` on the `workspace_invitations` table. All the data in the column will be lost.
  - You are about to drop the column `invited_by_user_id` on the `workspace_invitations` table. All the data in the column will be lost.
  - The primary key for the `workspace_users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `workspace_users` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `workspace_users` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `workspace_users` table. All the data in the column will be lost.
  - The primary key for the `workspaces` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `is_active` on the `workspaces` table. All the data in the column will be lost.
  - Changed the type of `id` on the `job_applications` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `workspace_id` on the `job_applications` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `created_by_user_id` on the `job_applications` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Made the column `currency` on table `job_applications` required. This step will fail if there are existing NULL values in that column.
  - Made the column `applied_at` on table `job_applications` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `job_application_id` to the `job_status_history` table without a default value. This is not possible if the table is not empty.
  - Added the required column `new_status` to the `job_status_history` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `id` on the `job_status_history` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `changed_by_user_id` on the `job_status_history` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `users` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `invited_by` to the `workspace_invitations` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `id` on the `workspace_invitations` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `workspace_id` on the `workspace_invitations` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `workspace_id` on the `workspace_users` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `user_id` on the `workspace_users` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `workspaces` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "job_applications" DROP CONSTRAINT "job_applications_created_by_user_id_fkey";

-- DropForeignKey
ALTER TABLE "job_applications" DROP CONSTRAINT "job_applications_workspace_id_fkey";

-- DropForeignKey
ALTER TABLE "job_status_history" DROP CONSTRAINT "job_status_history_changed_by_user_id_fkey";

-- DropForeignKey
ALTER TABLE "job_status_history" DROP CONSTRAINT "job_status_history_job_id_fkey";

-- DropForeignKey
ALTER TABLE "workspace_invitations" DROP CONSTRAINT "workspace_invitations_invited_by_user_id_fkey";

-- DropForeignKey
ALTER TABLE "workspace_invitations" DROP CONSTRAINT "workspace_invitations_workspace_id_fkey";

-- DropForeignKey
ALTER TABLE "workspace_users" DROP CONSTRAINT "workspace_users_user_id_fkey";

-- DropForeignKey
ALTER TABLE "workspace_users" DROP CONSTRAINT "workspace_users_workspace_id_fkey";

-- AlterTable
ALTER TABLE "job_applications" DROP CONSTRAINT "job_applications_pkey",
DROP COLUMN "deleted_at",
DROP COLUMN "employment_type",
DROP COLUMN "salary",
DROP COLUMN "seniority_level",
DROP COLUMN "source",
ADD COLUMN     "salary_max" INTEGER,
ADD COLUMN     "salary_min" INTEGER,
ADD COLUMN     "url" TEXT,
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "workspace_id",
ADD COLUMN     "workspace_id" UUID NOT NULL,
DROP COLUMN "created_by_user_id",
ADD COLUMN     "created_by_user_id" UUID NOT NULL,
ALTER COLUMN "status" SET DEFAULT 'applied',
ALTER COLUMN "status" SET DATA TYPE VARCHAR(50),
ALTER COLUMN "currency" SET NOT NULL,
ALTER COLUMN "currency" SET DEFAULT 'USD',
ALTER COLUMN "applied_at" SET NOT NULL,
ALTER COLUMN "applied_at" SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "applied_at" SET DATA TYPE TIMESTAMP(6),
ALTER COLUMN "created_at" SET DATA TYPE TIMESTAMP(6),
ALTER COLUMN "updated_at" SET DATA TYPE TIMESTAMP(6),
ADD CONSTRAINT "job_applications_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "job_status_history" DROP CONSTRAINT "job_status_history_pkey",
DROP COLUMN "changed_at",
DROP COLUMN "comment",
DROP COLUMN "fromStatus",
DROP COLUMN "job_id",
DROP COLUMN "toStatus",
ADD COLUMN     "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "job_application_id" UUID NOT NULL,
ADD COLUMN     "new_status" VARCHAR(50) NOT NULL,
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "old_status" VARCHAR(50),
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "changed_by_user_id",
ADD COLUMN     "changed_by_user_id" UUID NOT NULL,
ADD CONSTRAINT "job_status_history_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "users" DROP CONSTRAINT "users_pkey",
DROP COLUMN "phone",
DROP COLUMN "two_factor_enabled_at",
DROP COLUMN "two_factor_type",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ALTER COLUMN "is_active" SET DEFAULT true,
ALTER COLUMN "created_at" SET DATA TYPE TIMESTAMP(6),
ALTER COLUMN "updated_at" SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "updated_at" SET DATA TYPE TIMESTAMP(6),
ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "workspace_invitations" DROP CONSTRAINT "workspace_invitations_pkey",
DROP COLUMN "accepted_at",
DROP COLUMN "invited_by_user_id",
ADD COLUMN     "invited_by" UUID NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "workspace_id",
ADD COLUMN     "workspace_id" UUID NOT NULL,
ALTER COLUMN "role" SET DATA TYPE VARCHAR(50),
ALTER COLUMN "status" SET DEFAULT 'pending',
ALTER COLUMN "status" SET DATA TYPE VARCHAR(50),
ALTER COLUMN "expires_at" SET DATA TYPE TIMESTAMP(6),
ALTER COLUMN "created_at" SET DATA TYPE TIMESTAMP(6),
ADD CONSTRAINT "workspace_invitations_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "workspace_users" DROP CONSTRAINT "workspace_users_pkey",
DROP COLUMN "id",
DROP COLUMN "status",
DROP COLUMN "updated_at",
DROP COLUMN "workspace_id",
ADD COLUMN     "workspace_id" UUID NOT NULL,
DROP COLUMN "user_id",
ADD COLUMN     "user_id" UUID NOT NULL,
ALTER COLUMN "role" SET DATA TYPE VARCHAR(50),
ALTER COLUMN "created_at" SET DATA TYPE TIMESTAMP(6),
ADD CONSTRAINT "workspace_users_pkey" PRIMARY KEY ("workspace_id", "user_id");

-- AlterTable
ALTER TABLE "workspaces" DROP CONSTRAINT "workspaces_pkey",
DROP COLUMN "is_active",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ALTER COLUMN "created_at" SET DATA TYPE TIMESTAMP(6),
ALTER COLUMN "updated_at" SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "updated_at" SET DATA TYPE TIMESTAMP(6),
ADD CONSTRAINT "workspaces_pkey" PRIMARY KEY ("id");

-- AddForeignKey
ALTER TABLE "workspace_users" ADD CONSTRAINT "workspace_users_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "workspaces"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workspace_users" ADD CONSTRAINT "workspace_users_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workspace_invitations" ADD CONSTRAINT "workspace_invitations_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "workspaces"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workspace_invitations" ADD CONSTRAINT "workspace_invitations_invited_by_fkey" FOREIGN KEY ("invited_by") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_applications" ADD CONSTRAINT "job_applications_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "workspaces"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_applications" ADD CONSTRAINT "job_applications_created_by_user_id_fkey" FOREIGN KEY ("created_by_user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_status_history" ADD CONSTRAINT "job_status_history_job_application_id_fkey" FOREIGN KEY ("job_application_id") REFERENCES "job_applications"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_status_history" ADD CONSTRAINT "job_status_history_changed_by_user_id_fkey" FOREIGN KEY ("changed_by_user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
