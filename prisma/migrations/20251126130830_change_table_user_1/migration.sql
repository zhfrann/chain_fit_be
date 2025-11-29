-- CreateTable
CREATE TABLE `GymImage` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `gymId` INTEGER NOT NULL,
    `url` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `GymImage_gymId_idx`(`gymId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `GymImage` ADD CONSTRAINT `GymImage_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
