-- CreateTable
CREATE TABLE `SystemLog` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NULL,
    `ipAddress` VARCHAR(191) NOT NULL,
    `device` VARCHAR(191) NOT NULL,
    `action` VARCHAR(191) NOT NULL,
    `method` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `user_id` INTEGER NOT NULL AUTO_INCREMENT,
    `fullName` VARCHAR(191) NOT NULL,
    `username` VARCHAR(191) NOT NULL,
    `birthDate` DATETIME(3) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `gender` ENUM('male', 'female') NULL,
    `role` ENUM('admin', 'user') NOT NULL DEFAULT 'user',
    `verifiedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `User_username_key`(`username`),
    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Journal` (
    `journal_id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `title` VARCHAR(191) NULL,
    `content` VARCHAR(191) NOT NULL,
    `mood` ENUM('ADMIRATION', 'AMUSEMENT', 'ANGER', 'ANNOYANCE', 'APPROVAL', 'CARING', 'CONFUSION', 'CURIOSITY', 'DESIRE', 'DISAPPOINTMENT', 'DISAPPROVAL', 'DISGUST', 'EMBARRASSMENT', 'EXCITEMENT', 'FEAR', 'GRATITUDE', 'GRIEF', 'JOY', 'LOVE', 'NERVOUSNESS', 'OPTIMISM', 'PRIDE', 'REALIZATION', 'RELIEF', 'REMORSE', 'SADNESS', 'SURPRISE', 'NEUTRAL') NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`journal_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Quote` (
    `quote_id` INTEGER NOT NULL AUTO_INCREMENT,
    `category` ENUM('ADMIRATION', 'AMUSEMENT', 'ANGER', 'ANNOYANCE', 'APPROVAL', 'CARING', 'CONFUSION', 'CURIOSITY', 'DESIRE', 'DISAPPOINTMENT', 'DISAPPROVAL', 'DISGUST', 'EMBARRASSMENT', 'EXCITEMENT', 'FEAR', 'GRATITUDE', 'GRIEF', 'JOY', 'LOVE', 'NERVOUSNESS', 'OPTIMISM', 'PRIDE', 'REALIZATION', 'RELIEF', 'REMORSE', 'SADNESS', 'SURPRISE', 'NEUTRAL') NOT NULL,
    `text` VARCHAR(191) NOT NULL,
    `author` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`quote_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `QuoteLog` (
    `quote_log_id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `quoteId` INTEGER NOT NULL,
    `action` ENUM('click', 'like', 'journal_assigned') NOT NULL,
    `count` INTEGER NOT NULL DEFAULT 1,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `QuoteLog_userId_quoteId_action_key`(`userId`, `quoteId`, `action`),
    PRIMARY KEY (`quote_log_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `SystemLog` ADD CONSTRAINT `SystemLog_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Journal` ADD CONSTRAINT `Journal_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `QuoteLog` ADD CONSTRAINT `QuoteLog_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `QuoteLog` ADD CONSTRAINT `QuoteLog_quoteId_fkey` FOREIGN KEY (`quoteId`) REFERENCES `Quote`(`quote_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
