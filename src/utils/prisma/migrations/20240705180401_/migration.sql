/*
  Warnings:

  - You are about to drop the column `level` on the `referrals_quests_profit` table. All the data in the column will be lost.
  - Added the required column `level` to the `referrals_quests` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "referrals_quests" ADD COLUMN     "level" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "referrals_quests_profit" DROP COLUMN "level";
