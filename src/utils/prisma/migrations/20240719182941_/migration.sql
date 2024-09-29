/*
  Warnings:

  - You are about to drop the `IdMapping` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `refferals` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `refferals_early_bonuses` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "refferals" DROP CONSTRAINT "refferals_referral_id_fkey";

-- DropForeignKey
ALTER TABLE "refferals_early_bonuses" DROP CONSTRAINT "refferals_early_bonuses_player_id_fkey";

-- DropTable
DROP TABLE "IdMapping";

-- DropTable
DROP TABLE "refferals";

-- DropTable
DROP TABLE "refferals_early_bonuses";

-- CreateTable
CREATE TABLE "referrals_early_bonuses" (
    "id" TEXT NOT NULL,
    "account_type" "AccountType",
    "honey" DOUBLE PRECISION NOT NULL,
    "multiplier" DOUBLE PRECISION,
    "player_id" TEXT,

    CONSTRAINT "referrals_early_bonuses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "referrals" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "referrer_id" TEXT NOT NULL,
    "referral_id" TEXT NOT NULL,

    CONSTRAINT "referrals_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "referrals_early_bonuses" ADD CONSTRAINT "referrals_early_bonuses_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "referrals" ADD CONSTRAINT "referrals_referral_id_fkey" FOREIGN KEY ("referral_id") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;
