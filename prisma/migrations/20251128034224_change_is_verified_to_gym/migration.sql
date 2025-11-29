/*
  Warnings:

  - You are about to drop the column `isVerified` on the `user` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `gym` ADD COLUMN `isVerified` BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `isVerified`;
