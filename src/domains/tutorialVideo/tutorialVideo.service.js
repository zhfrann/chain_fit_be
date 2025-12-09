import prisma from "../../config/db.js";
import BaseError from "../../base_classes/base-error.js";

class TutorialVideoService {
  
  // Helper: Dapatkan Gym ID milik Owner
  async _getAuthorizedGymIds(user) {
    if (user.role === 'OWNER') {
      const gym = await prisma.gym.findFirst({
        where: { ownerId: user.id },
        select: { id: true }
      });
      if (!gym) throw BaseError.notFound('Gym tidak ditemukan untuk Owner ini');
      return [gym.id];
    } 
    
    else if (user.role === 'MEMBER') {
      const memberships = await prisma.membership.findMany({
        where: {
          userId: user.id,
          status: 'ACTIVE',
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

  // Helper: Pastikan Equipment ada di Gym milik Owner
  async _validateEquipmentOwnership(gymId, equipmentId) {
    const equipment = await prisma.equipment.findFirst({
      where: {
        id: equipmentId,
        gymId: gymId
      }
    });

    if (!equipment) {
      throw BaseError.notFound('Equipment tidak ditemukan di gym Anda');
    }
  }

  // 1. Create Video
  async create(ownerId, data) {
    const gymId = await this._getOwnerGymId(ownerId);
    
    await this._validateEquipmentOwnership(gymId, data.equipmentId);

    return await prisma.tutorialVideo.create({
      data: {
        gymId: gymId,
        equipmentId: data.equipmentId,
        title: data.title,
        url: data.url,
        description: data.description
      }
    });
  }

  // 2. Get All Videos (Bisa filter by specific Equipment)
  async findAll(user, query) {
    const { page = 1, limit = 10, search, equipmentId } = query;
    const skip = (page - 1) * limit;

    const authorizedGymIds = await this._getAuthorizedGymIds(user);

    const whereCondition = {
      gymId: { in: authorizedGymIds },
      ...(equipmentId && { equipmentId: parseInt(equipmentId) }),
      ...(search && {
        title: { contains: search }
      })
    };

    const [videos, total] = await Promise.all([
      prisma.tutorialVideo.findMany({
        where: whereCondition,
        skip: parseInt(skip),
        take: parseInt(limit),
        orderBy: { createdAt: 'desc' },
        include: {
          equipment: {
            select: { id: true, name: true, photo: true }
          }
        }
      }),
      prisma.tutorialVideo.count({ where: whereCondition })
    ]);

    return {
      data: videos,
      meta: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        totalPages: Math.ceil(total / limit)
      }
    };
  }

  // 3. Get One Video
  async findOne(user, videoId) {
    const authorizedGymIds = await this._getAuthorizedGymIds(user);

    const video = await prisma.tutorialVideo.findFirst({
      where: {
        id: parseInt(videoId),
        gymId: { in: authorizedGymIds }
      },
      include: {
        equipment: {
          select: { id: true, name: true }
        },
        gym: {
          select: { name: true }
        }
      }
    });

    if (!video) {
      throw BaseError.notFound('Video tidak ditemukan atau Anda tidak memiliki akses membership di gym ini');
    }

    return video;
  }

  // 4. Update Video
  async update(ownerId, videoId, data) {
    const gymId = await this._getOwnerGymId(ownerId);

    const existingVideo = await this.findOne(ownerId, videoId);

    if (data.equipmentId && data.equipmentId !== existingVideo.equipmentId) {
      await this._validateEquipmentOwnership(gymId, data.equipmentId);
    }

    return await prisma.tutorialVideo.update({
      where: { id: parseInt(videoId) },
      data: data
    });
  }

  // 5. Delete Video
  async delete(ownerId, videoId) {
    await this.findOne(ownerId, videoId);

    return await prisma.tutorialVideo.delete({
      where: { id: parseInt(videoId) }
    });
  }
}

export default new TutorialVideoService();