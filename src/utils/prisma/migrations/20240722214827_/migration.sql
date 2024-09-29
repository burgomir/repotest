/*
  Warnings:

  - Changed the type of `profit` on the `profit` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "profit" DROP COLUMN "profit",
ADD COLUMN     "profit" DOUBLE PRECISION NOT NULL;
