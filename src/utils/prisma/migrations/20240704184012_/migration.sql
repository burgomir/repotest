/*
  Warnings:

  - You are about to drop the column `farmingDate` on the `players` table. All the data in the column will be lost.
  - You are about to drop the column `accountType` on the `refferals_early_bonuses` table. All the data in the column will be lost.
  - You are about to drop the `PlayerRankProfit` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[quest_id]` on the table `medias` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "PlayerRankProfit" DROP CONSTRAINT "PlayerRankProfit_player_id_fkey";

-- DropForeignKey
ALTER TABLE "PlayerRankProfit" DROP CONSTRAINT "PlayerRankProfit_rank_id_fkey";

-- AlterTable
ALTER TABLE "medias" ADD COLUMN     "quest_id" TEXT;

-- AlterTable
ALTER TABLE "players" DROP COLUMN "farmingDate",
ADD COLUMN     "farming_date" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "refferals_early_bonuses" DROP COLUMN "accountType",
ADD COLUMN     "account_type" "AccountType";

-- DropTable
DROP TABLE "PlayerRankProfit";

-- CreateTable
CREATE TABLE "player_rank_profit" (
    "id" TEXT NOT NULL,
    "profit" DOUBLE PRECISION NOT NULL,
    "is_collected" BOOLEAN NOT NULL DEFAULT false,
    "rank_id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,

    CONSTRAINT "player_rank_profit_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "medias_quest_id_key" ON "medias"("quest_id");

-- AddForeignKey
ALTER TABLE "medias" ADD CONSTRAINT "medias_quest_id_fkey" FOREIGN KEY ("quest_id") REFERENCES "quests"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_rank_profit" ADD CONSTRAINT "player_rank_profit_rank_id_fkey" FOREIGN KEY ("rank_id") REFERENCES "ranks"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_rank_profit" ADD CONSTRAINT "player_rank_profit_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;
