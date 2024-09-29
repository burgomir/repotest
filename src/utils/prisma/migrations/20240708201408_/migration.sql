-- DropForeignKey
ALTER TABLE "referrals_profit" DROP CONSTRAINT "referrals_profit_player_id_fkey";

-- AddForeignKey
ALTER TABLE "referrals_profit" ADD CONSTRAINT "referrals_profit_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;
