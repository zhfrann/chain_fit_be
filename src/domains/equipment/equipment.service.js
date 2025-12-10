import prisma from "../../config/db.js";
import BaseError from "../../base_classes/base-error.js";

class EquipmentService {
  /**
   * Helper untuk mendapatkan Gym milik owner.
   * Jika owner belum punya gym, throw error.
   */
  async _getAuthorizedGymIds(user) {
    if (user.role === 'OWNER' || user.role === 'PENJAGA') {
      const gyms = await prisma.gym.findMany({
        where: { ownerId: user.id },
        select: { id: true }
      });
      
      if (gyms.length === 0) {
        throw BaseError.notFound('Anda tidak memiliki gym');
      }

      return gyms.map(g => g.id);
    }
    
    else if (user.role === 'MEMBER') {
      const memberships = await prisma.membership.findMany({
        where: {
          userId: user.id,
          status: 'AKTIF',
          endDate: { gte: new Date() }
        },
        select: { gymId: true }
      });

      if (memberships.length === 0) {
        throw BaseError.notFound('Anda tidak memiliki membership aktif di gym manapun');
      }

      return memberships.map(m => m.gymId);
    }
    
    else {
      throw BaseError.forbidden('Role tidak diizinkan');
    }
  }

  async _getOwnerGym(ownerId) {
    const gym = await prisma.gym.findFirst({
      where: { ownerId: ownerId },
      select: { id: true }
    });

    if (!gym) {
      throw BaseError.notFound('Gym tidak ditemukan untuk Owner ini');
    }
    return gym;
  }

  // 1. Create Equipment
  async create(user, data) {
    // Ambil semua gym yang dimiliki user
    const authorizedGymIds = await this._getAuthorizedGymIds(user);

    // Jika applyToAll = true → buat di semua gym
    if (data.applyToAll) {
      const createData = authorizedGymIds.map(gymId => ({
        gymId,
        name: data.name,
        healthStatus: data.healthStatus,
        photo: data.photo
      }));

      return await prisma.equipment.createMany({
        data: createData
      });
    }

    if (!data.gymId) {
      throw BaseError.badRequest("gymId harus diisi jika applyToAll = false");
    }

    const targetGymId = parseInt(data.gymId);

    if (!authorizedGymIds.includes(targetGymId)) {
      throw BaseError.forbidden("Anda tidak memiliki akses ke gym ini");
    }

    // Create equipment untuk gym tertentu
    return await prisma.equipment.create({
      data: {
        gymId: targetGymId,
        name: data.name,
        healthStatus: data.healthStatus,
        photo: data.photo
      }
    });
  }


  // 2. Get All Equipment (Pagination + Search + Security Check)
  async findAll(user, query) {
    const { page = 1, limit = 10, search, gymId} = query;
    const skip = (page - 1) * limit;

    const authorizedGymIds = await this._getAuthorizedGymIds(user);

    // Filter kondisi: Milik gym owner INI dan opsional search nama
    const whereCondition = {
      gymId: { in: authorizedGymIds },
      ...(gymId && { gymId: parseInt(gymId) }),
      ...(search && {
        name: { contains: search}
      })
    };

    const [equipments, total] = await Promise.all([
      prisma.equipment.findMany({
        where: whereCondition,
        skip: parseInt(skip),
        take: parseInt(limit),
        orderBy: { createdAt: 'desc' },
        select: {
          id: true,
          name: true,
          healthStatus: true,
          photo: true,
          createdAt: true
        }
      }),
      prisma.equipment.count({ where: whereCondition })
    ]);

    return {
      data: equipments,
      meta: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        totalPages: Math.ceil(total / limit)
      }
    };
  }

  // 3. Get One Equipment Detail
  async findOne(user, equipmentId) {
    const authorizedGymIds = await this._getAuthorizedGymIds(user);
    
    const equipment = await prisma.equipment.findFirst({
      where: {
        id: parseInt(equipmentId),
        gymId: { in: authorizedGymIds }
      },
      include: {
        histories: {
          take: 5, // Tampilkan 5 history terakhir (opsional)
          orderBy: { createdAt: 'desc' }
        },
        gym: {
          select: { name: true }
        }
      }
    });

    if (!equipment) {
      throw BaseError.notFound('Equipment tidak ditemukan atau bukan milik Anda');
    }

    return equipment;
  }

  // 4. Update Equipment
  async update(ownerId, equipmentId, data) {
    // Cek eksistensi dan kepemilikan dulu
    await this.findOne(ownerId, equipmentId);

    return await prisma.equipment.update({
      where: { id: parseInt(equipmentId) },
      data: data
    });
  }

  // 5. Delete Equipment
  async delete(ownerId, equipmentId) {
    // Cek eksistensi dan kepemilikan dulu
    await this.findOne(ownerId, equipmentId);

    return await prisma.equipment.delete({
      where: { id: parseInt(equipmentId) }
    });
  }
}

export default new EquipmentService();