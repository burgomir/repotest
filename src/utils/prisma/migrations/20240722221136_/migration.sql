-- DropForeignKey
ALTER TABLE "profit" DROP CONSTRAINT "profit_player_id_fkey";

-- AddForeignKey
ALTER TABLE "profit" ADD CONSTRAINT "profit_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;
