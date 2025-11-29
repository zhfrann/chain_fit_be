-- DropForeignKey
ALTER TABLE `attendance` DROP FOREIGN KEY `Attendance_gymId_fkey`;

-- DropForeignKey
ALTER TABLE `equipment` DROP FOREIGN KEY `Equipment_gymId_fkey`;

-- DropForeignKey
ALTER TABLE `equipmenthistory` DROP FOREIGN KEY `EquipmentHistory_gymId_fkey`;

-- DropForeignKey
ALTER TABLE `gymimage` DROP FOREIGN KEY `GymImage_gymId_fkey`;

-- DropForeignKey
ALTER TABLE `membership` DROP FOREIGN KEY `Membership_gymId_fkey`;

-- DropForeignKey
ALTER TABLE `transaction` DROP FOREIGN KEY `Transaction_gymId_fkey`;

-- DropForeignKey
ALTER TABLE `tutorialvideo` DROP FOREIGN KEY `TutorialVideo_gymId_fkey`;

-- AddForeignKey
ALTER TABLE `GymImage` ADD CONSTRAINT `GymImage_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Membership` ADD CONSTRAINT `Membership_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Equipment` ADD CONSTRAINT `Equipment_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EquipmentHistory` ADD CONSTRAINT `EquipmentHistory_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TutorialVideo` ADD CONSTRAINT `TutorialVideo_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
