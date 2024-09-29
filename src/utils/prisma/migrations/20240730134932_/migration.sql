-- DropForeignKey
ALTER TABLE "players_quests" DROP CONSTRAINT "players_quests_quest_id_fkey";

-- AddForeignKey
ALTER TABLE "players_quests" ADD CONSTRAINT "players_quests_quest_id_fkey" FOREIGN KEY ("quest_id") REFERENCES "quests"("id") ON DELETE CASCADE ON UPDATE CASCADE;
