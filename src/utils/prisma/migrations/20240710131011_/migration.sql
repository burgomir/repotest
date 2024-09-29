/*
  Warnings:

  - You are about to drop the column `completed` on the `players_quests` table. All the data in the column will be lost.
  - Added the required column `is_completed` to the `players_quests` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "players_quests" DROP COLUMN "completed",
ADD COLUMN     "is_completed" BOOLEAN NOT NULL;
