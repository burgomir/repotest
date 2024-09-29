-- CreateTable
CREATE TABLE "IdMapping" (
    "id" SERIAL NOT NULL,
    "tgId" TEXT NOT NULL,
    "oldId" INTEGER NOT NULL,
    "newId" TEXT NOT NULL,

    CONSTRAINT "IdMapping_pkey" PRIMARY KEY ("id")
);
