/*
  Warnings:

  - The values [RUSAK] on the enum `Equipment_healthStatus` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `verifiedAt` on the `user` table. All the data in the column will be lost.
  - You are about to drop the `financialreport` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `financialreport` DROP FOREIGN KEY `FinancialReport_gymId_fkey`;

-- AlterTable
ALTER TABLE `equipment` MODIFY `healthStatus` ENUM('BAIK', 'BUTUH_PERAWATAN', 'RUSAK0') NOT NULL;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `verifiedAt`,
    ADD COLUMN `isVerified` BOOLEAN NULL,
    MODIFY `role` ENUM('OWNER', 'PENJAGA', 'MEMBER', 'ADMIN') NOT NULL DEFAULT 'MEMBER';

-- DropTable
DROP TABLE `financialreport`;
