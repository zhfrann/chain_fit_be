/*
  Warnings:

  - You are about to drop the column `gender` on the `user` table. All the data in the column will be lost.
  - You are about to drop the `journal` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `quote` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `quotelog` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `journal` DROP FOREIGN KEY `Journal_userId_fkey`;

-- DropForeignKey
ALTER TABLE `quotelog` DROP FOREIGN KEY `QuoteLog_quoteId_fkey`;

-- DropForeignKey
ALTER TABLE `quotelog` DROP FOREIGN KEY `QuoteLog_userId_fkey`;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `gender`;

-- DropTable
DROP TABLE `journal`;

-- DropTable
DROP TABLE `quote`;

-- DropTable
DROP TABLE `quotelog`;
