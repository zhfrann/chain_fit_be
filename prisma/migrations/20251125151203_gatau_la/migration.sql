/*
  Warnings:

  - The values [RUSAK0] on the enum `Equipment_healthStatus` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterTable
ALTER TABLE `equipment` MODIFY `healthStatus` ENUM('BAIK', 'BUTUH_PERAWATAN', 'RUSAK') NOT NULL;
