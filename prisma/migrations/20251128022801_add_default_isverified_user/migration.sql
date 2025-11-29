/*
  Warnings:

  - Made the column `isVerified` on table `user` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `user` MODIFY `isVerified` BOOLEAN NOT NULL DEFAULT false;
