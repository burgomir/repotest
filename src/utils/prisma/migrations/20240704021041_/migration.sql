/*
  Warnings:

  - A unique constraint covering the columns `[tg_id]` on the table `players` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "referrals_profit" DROP CONSTRAINT "referrals_profit_player_id_fkey";

-- CreateIndex
CREATE UNIQUE INDEX "players_tg_id_key" ON "players"("tg_id");

-- AddForeignKey
ALTER TABLE "referrals_profit" ADD CONSTRAINT "referrals_profit_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("tg_id") ON DELETE CASCADE ON UPDATE CASCADE;
