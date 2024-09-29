-- DropForeignKey
ALTER TABLE "player_rank_profit" DROP CONSTRAINT "player_rank_profit_rank_id_fkey";

-- AddForeignKey
ALTER TABLE "player_rank_profit" ADD CONSTRAINT "player_rank_profit_rank_id_fkey" FOREIGN KEY ("rank_id") REFERENCES "ranks"("id") ON DELETE SET DEFAULT ON UPDATE CASCADE;
