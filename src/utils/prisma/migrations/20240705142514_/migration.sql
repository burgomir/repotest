-- DropForeignKey
ALTER TABLE "refferals_early_bonuses" DROP CONSTRAINT "refferals_early_bonuses_player_id_fkey";

-- AddForeignKey
ALTER TABLE "refferals_early_bonuses" ADD CONSTRAINT "refferals_early_bonuses_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;
