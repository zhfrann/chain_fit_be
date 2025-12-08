/*
  Warnings:

  - A unique constraint covering the columns `[orderId]` on the table `Transaction` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `transaction` ADD COLUMN `orderId` VARCHAR(191) NULL,
    ADD COLUMN `paymentMethod` VARCHAR(191) NULL,
    ADD COLUMN `status` ENUM('PENDING', 'PAID', 'FAILED', 'EXPIRED', 'REFUNDED') NOT NULL DEFAULT 'PENDING';

-- CreateIndex
CREATE UNIQUE INDEX `Transaction_orderId_key` ON `Transaction`(`orderId`);
