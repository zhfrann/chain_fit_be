/*
  Warnings:

  - A unique constraint covering the columns `[gymId,name]` on the table `MembershipPackage` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `gymId` to the `MembershipPackage` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `membershippackage` ADD COLUMN `gymId` INTEGER NOT NULL;

-- CreateIndex
CREATE INDEX `MembershipPackage_gymId_idx` ON `MembershipPackage`(`gymId`);

-- CreateIndex
CREATE UNIQUE INDEX `MembershipPackage_gymId_name_key` ON `MembershipPackage`(`gymId`, `name`);

-- AddForeignKey
ALTER TABLE `MembershipPackage` ADD CONSTRAINT `MembershipPackage_gymId_fkey` FOREIGN KEY (`gymId`) REFERENCES `Gym`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
