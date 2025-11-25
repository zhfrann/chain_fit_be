/*
  Warnings:

  - The primary key for the `user` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `birthDate` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `current_login_at` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `fullName` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `last_login_at` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `user` table. All the data in the column will be lost.
  - You are about to alter the column `role` on the `user` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(0))` to `Enum(EnumId(0))`.
  - Added the required column `id` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `systemlog` DROP FOREIGN KEY `SystemLog_userId_fkey`;

-- DropIndex
DROP INDEX `SystemLog_userId_fkey` ON `systemlog`;

-- AlterTable
ALTER TABLE `user` DROP PRIMARY KEY,
    DROP COLUMN `birthDate`,
    DROP COLUMN `current_login_at`,
    DROP COLUMN `fullName`,
    DROP COLUMN `last_login_at`,
    DROP COLUMN `user_id`,
    ADD COLUMN `gymId` INTEGER NULL,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `name` VARCHAR(191) NOT NULL,
    ADD COLUMN `profileImage` VARCHAR(191) NULL,
    MODIFY `role` ENUM('OWNER', 'PENJAGA', 'MEMBER') NOT NULL,
    ADD PRIMARY KEY (`id`);

-- CreateTable
CREATE TABLE `Gym` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `maxCapacity` INTEGER NULL,
    `address` VARCHAR(191) NULL,
    `jamOperasional` VARCHAR(191) NULL,
    `ownerId` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MembershipPackage` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `price` DECIMAL(12, 2) NOT NULL,
    `durationDays` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Membership` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `gymId` INTEGER NOT NULL,
    `packageId` INTEGER NOT NULL,
    `startDate` DATETIME(3) NOT NULL,
    `endDate` DATETIME(3) NOT NULL,
    `status` ENUM('AKTIF', 'TIDAK') NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Membership_userId_idx`(`userId`),
    INDEX `Membership_gymId_idx`(`gymId`),
    INDEX `Membership_packageId_idx`(`packageId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Attendance` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `membershipId` INTEGER NOT NULL,
    `gymId` INTEGER NOT NULL,
    `checkInAt` DATETIME(3) NOT NULL,
    `checkOutAt` DATETIME(3) NULL,
    `createdById` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Attendance_membershipId_idx`(`membershipId`),
    INDEX `Attendance_gymId_idx`(`gymId`),
    INDEX `Attendance_createdById_idx`(`createdById`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transaction` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `gymId` INTEGER NOT NULL,
    `userId` INTEGER NULL,
    `membershipId` INTEGER NULL,
    `date` DATETIME(3) NOT NULL,
    `amount` DECIMAL(12, 2) NOT NULL,
    `type` ENUM('PENDAPATAN', 'PENGELUARAN') NOT NULL,
    `note` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Transaction_gymId_idx`(`gymId`),
    INDEX `Transaction_userId_idx`(`userId`),
    INDEX `Transaction_membershipId_idx`(`membershipId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FinancialReport` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `gymId` INTEGER NOT NULL,
    `periodStart` DATETIME(3) NOT NULL,
    `periodEnd` DATETIME(3) NOT NULL,
    `totalIncome` DECIMAL(14, 2) NOT NULL,
    `totalExpense` DECIMAL(14, 2) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `FinancialReport_gymId_idx`(`gymId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Equipment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `gymId` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `healthStatus` ENUM('BAIK', 'BUTUH_PERAWATAN', 'RUSAK') NOT NULL,
    `photo` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Equipment_gymId_idx`(`gymId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `EquipmentHistory` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `equipmentId` INTEGER NOT NULL,
    `gymId` INTEGER NOT NULL,
    `date` DATETIME(3) NOT NULL,
    `type` ENUM('KERUSAKAN', 'PERBAIKAN') NOT NULL,
    `description` VARCHAR(191) NULL,
    `reportedById` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `EquipmentHistory_equipmentId_idx`(`equipmentId`),
    INDEX `EquipmentHistory_gymId_idx`(`gymId`),
    INDEX `EquipmentHistory_reportedById_idx`(`reportedById`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TutorialVideo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `gymId` INTEGER NULL,
    `equipmentId` INTEGER NULL,
    `title` VARCHAR(191) NOT NULL,
    `url` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `TutorialVideo_gymId_idx`(`gymId`),
    INDEX `TutorialVideo_equipmentId_idx`(`equipmentId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `SystemLog` ADD CONSTRAINT `SystemLog_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Gym` ADD CONSTRAINT `Gym_ownerId_fkey` FOREIGN KEY (`ownerId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Membership` ADD CONSTRAINT `Membership_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Membership` ADD CONSTRAINT `Membership_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Membership` ADD CONSTRAINT `Membership_packageId_fkey` FOREIGN KEY (`packageId`) REFERENCES `MembershipPackage`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_membershipId_fkey` FOREIGN KEY (`membershipId`) REFERENCES `Membership`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_membershipId_fkey` FOREIGN KEY (`membershipId`) REFERENCES `Membership`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FinancialReport` ADD CONSTRAINT `FinancialReport_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Equipment` ADD CONSTRAINT `Equipment_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EquipmentHistory` ADD CONSTRAINT `EquipmentHistory_equipmentId_fkey` FOREIGN KEY (`equipmentId`) REFERENCES `Equipment`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EquipmentHistory` ADD CONSTRAINT `EquipmentHistory_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EquipmentHistory` ADD CONSTRAINT `EquipmentHistory_reportedById_fkey` FOREIGN KEY (`reportedById`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TutorialVideo` ADD CONSTRAINT `TutorialVideo_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TutorialVideo` ADD CONSTRAINT `TutorialVideo_equipmentId_fkey` FOREIGN KEY (`equipmentId`) REFERENCES `Equipment`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
