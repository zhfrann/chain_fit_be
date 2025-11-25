-- AlterTable
ALTER TABLE `user` ADD COLUMN `current_login_at` DATETIME(3) NULL,
    ADD COLUMN `last_login_at` DATETIME(3) NULL;
