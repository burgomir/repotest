-- DropForeignKey
ALTER TABLE "player_ranks" DROP CONSTRAINT "player_ranks_rank_id_fkey";

-- AddForeignKey
ALTER TABLE "player_ranks" ADD CONSTRAINT "player_ranks_rank_id_fkey" FOREIGN KEY ("rank_id") REFERENCES "ranks"("id") ON DELETE CASCADE ON UPDATE CASCADE;
