-- CreateEnum
CREATE TYPE "FileType" AS ENUM ('VIDEO', 'IMAGE');

-- CreateEnum
CREATE TYPE "progressType" AS ENUM ('Referral', 'Rank');

-- CreateEnum
CREATE TYPE "AccountType" AS ENUM ('PREMIUM', 'COMMON');

-- CreateTable
CREATE TABLE "bonuses" (
    "id" TEXT NOT NULL,

    CONSTRAINT "bonuses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "logs" (
    "id" SERIAL NOT NULL,
    "host" TEXT,
    "url" TEXT,
    "status_code" INTEGER,
    "method" TEXT,
    "user" TEXT,
    "context" TEXT,
    "message" TEXT,
    "level" TEXT,
    "time" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),

    CONSTRAINT "logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "medias" (
    "id" TEXT NOT NULL,
    "file_name" TEXT NOT NULL,
    "file_path" TEXT NOT NULL,
    "size" TEXT NOT NULL,
    "mime_type" TEXT NOT NULL,
    "original_name" TEXT NOT NULL,
    "file_type" "FileType" NOT NULL,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),

    CONSTRAINT "medias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orcs" (
    "id" TEXT NOT NULL,

    CONSTRAINT "orcs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "player_bonuses" (
    "id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,
    "bonus_id" TEXT NOT NULL,
    "available" BOOLEAN NOT NULL,

    CONSTRAINT "player_bonuses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "players_orcs" (
    "id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,
    "bossStreak" INTEGER DEFAULT 0,
    "last_boss_date" TIMESTAMP(3),
    "hp" INTEGER NOT NULL,

    CONSTRAINT "players_orcs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "player_progress" (
    "id" TEXT NOT NULL,
    "progress" DOUBLE PRECISION NOT NULL,
    "type" "progressType" NOT NULL,
    "player_id" TEXT NOT NULL,

    CONSTRAINT "player_progress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "players_quests" (
    "id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,
    "quest_id" TEXT NOT NULL,
    "completed" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3),

    CONSTRAINT "players_quests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlayerRankProfit" (
    "id" TEXT NOT NULL,
    "profit" DOUBLE PRECISION NOT NULL,
    "isCollected" BOOLEAN NOT NULL DEFAULT false,
    "rank_id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,

    CONSTRAINT "PlayerRankProfit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "player_ranks" (
    "id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,
    "rank_id" TEXT NOT NULL,
    "achieved_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "player_ranks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "players" (
    "id" TEXT NOT NULL,
    "honey_latest" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "honey_max" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "balance" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "last_login" TIMESTAMP(3),
    "last_logout" TIMESTAMP(3),
    "level_id" TEXT,
    "referred_by_id" TEXT,
    "tg_id" TEXT NOT NULL,
    "is_premium" BOOLEAN NOT NULL,
    "user_name" TEXT NOT NULL,
    "referral_profit" DOUBLE PRECISION DEFAULT 0,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "farmingDate" TIMESTAMP(3),

    CONSTRAINT "players_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "profit" (
    "id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,
    "profit" TEXT NOT NULL,

    CONSTRAINT "profit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "quests" (
    "id" TEXT NOT NULL,
    "link" TEXT NOT NULL,
    "reward" DOUBLE PRECISION NOT NULL,
    "terms" TEXT NOT NULL,

    CONSTRAINT "quests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ranks" (
    "id" TEXT NOT NULL,
    "bonus_amount" DOUBLE PRECISION NOT NULL,
    "description" TEXT NOT NULL,
    "rank" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "required_amount" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "ranks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "refferals_early_bonuses" (
    "id" TEXT NOT NULL,
    "accountType" "AccountType",
    "honey" DOUBLE PRECISION NOT NULL,
    "multiplier" DOUBLE PRECISION,
    "player_id" TEXT,

    CONSTRAINT "refferals_early_bonuses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "referrals_quests_profit" (
    "id" TEXT NOT NULL,
    "referral_count" INTEGER NOT NULL,
    "reward" DOUBLE PRECISION NOT NULL,
    "claimed" BOOLEAN NOT NULL DEFAULT false,
    "player_id" TEXT NOT NULL,
    "referral_quest_id" TEXT NOT NULL,

    CONSTRAINT "referrals_quests_profit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "refferals" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "referrer_id" TEXT NOT NULL,
    "referral_id" TEXT NOT NULL,

    CONSTRAINT "refferals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "referrals_profit" (
    "id" TEXT NOT NULL,
    "honey" DOUBLE PRECISION NOT NULL,
    "player_id" TEXT NOT NULL,

    CONSTRAINT "referrals_profit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "referrals_quests" (
    "id" TEXT NOT NULL,
    "referral_count" INTEGER NOT NULL,
    "reward" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "referrals_quests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "player_tokens" (
    "id" TEXT NOT NULL,
    "refresh_token" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),

    CONSTRAINT "player_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "players_orcs_player_id_key" ON "players_orcs"("player_id");

-- CreateIndex
CREATE UNIQUE INDEX "referrals_profit_player_id_key" ON "referrals_profit"("player_id");

-- CreateIndex
CREATE UNIQUE INDEX "player_tokens_player_id_key" ON "player_tokens"("player_id");

-- AddForeignKey
ALTER TABLE "player_bonuses" ADD CONSTRAINT "player_bonuses_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_bonuses" ADD CONSTRAINT "player_bonuses_bonus_id_fkey" FOREIGN KEY ("bonus_id") REFERENCES "bonuses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "players_orcs" ADD CONSTRAINT "players_orcs_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_progress" ADD CONSTRAINT "player_progress_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "players_quests" ADD CONSTRAINT "players_quests_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "players_quests" ADD CONSTRAINT "players_quests_quest_id_fkey" FOREIGN KEY ("quest_id") REFERENCES "quests"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerRankProfit" ADD CONSTRAINT "PlayerRankProfit_rank_id_fkey" FOREIGN KEY ("rank_id") REFERENCES "ranks"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerRankProfit" ADD CONSTRAINT "PlayerRankProfit_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_ranks" ADD CONSTRAINT "player_ranks_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_ranks" ADD CONSTRAINT "player_ranks_rank_id_fkey" FOREIGN KEY ("rank_id") REFERENCES "ranks"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "profit" ADD CONSTRAINT "profit_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "refferals_early_bonuses" ADD CONSTRAINT "refferals_early_bonuses_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "referrals_quests_profit" ADD CONSTRAINT "referrals_quests_profit_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "referrals_quests_profit" ADD CONSTRAINT "referrals_quests_profit_referral_quest_id_fkey" FOREIGN KEY ("referral_quest_id") REFERENCES "referrals_quests"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "refferals" ADD CONSTRAINT "refferals_referral_id_fkey" FOREIGN KEY ("referral_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "referrals_profit" ADD CONSTRAINT "referrals_profit_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_tokens" ADD CONSTRAINT "player_tokens_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;
