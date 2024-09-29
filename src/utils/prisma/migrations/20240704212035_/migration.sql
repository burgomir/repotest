/*
  Warnings:

  - Added the required column `description` to the `quests` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description` to the `referrals_quests` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "quests" ADD COLUMN     "description" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "referrals_quests" ADD COLUMN     "description" TEXT NOT NULL;
