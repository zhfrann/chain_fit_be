import prisma from "../src/config/db.js";
import { hashPassword } from "../src/utils/passwordConfig.js";

async function main() {
console.log('🌱 Starting database seed...');

}

main()
  .catch((e) => console.error("❌ Error seeding quotes data:", e))
  .finally(async () => await prisma.$disconnect());
