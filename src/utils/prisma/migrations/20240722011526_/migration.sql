-- DropForeignKey
ALTER TABLE "player_rank_profit" DROP CONSTRAINT "player_rank_profit_rank_id_fkey";

-- AlterTable
ALTER TABLE "player_rank_profit" ALTER COLUMN "rank_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "player_rank_profit" ADD CONSTRAINT "player_rank_profit_rank_id_fkey" FOREIGN KEY ("rank_id") REFERENCES "ranks"("id") ON DELETE SET NULL ON UPDATE CASCADE;
