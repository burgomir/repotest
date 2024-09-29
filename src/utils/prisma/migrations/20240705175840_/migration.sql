/*
  Warnings:

  - Added the required column `level` to the `referrals_quests_profit` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "referrals_quests_profit" ADD COLUMN     "level" INTEGER NOT NULL;
