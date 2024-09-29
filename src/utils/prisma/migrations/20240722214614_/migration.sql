/*
  Warnings:

  - Added the required column `profit_type` to the `profit` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "ProfitType" AS ENUM ('quest', 'referralQuest', 'rank', 'referralProfit', 'bossKill', 'click');

-- AlterTable
ALTER TABLE "profit" ADD COLUMN     "profit_type" "ProfitType" NOT NULL;
