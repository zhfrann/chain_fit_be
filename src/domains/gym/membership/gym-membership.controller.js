import { createdResponse, successResponse } from "../../../utils/response.js";
import gymMembershipService from "./gym-membership.service.js";


class GymMembershipController {

    async getMembership(req, res){
        const userId = req.user.id;
        const membership = await gymMembershipService.getAllMemberships(userId);
        return successResponse(res, membership);
    }
    
    async index(req, res){
        const gymId = req.params.id;
        const membership = await gymMembershipService.getAllUserMembership(gymId);
        return successResponse(res, membership);
    }

    async show(req, res){
        const gymId = req.params.id;
        const memberId = req.params.membershipId;
        const membership = await gymMembershipService.getUserMembershipById(gymId, memberId);
        return successResponse(res, membership);
    }
    
    
    async create(req, res){
        const {name, email} = req.body;
        const gymId = req.params.id;
        const paketId = req.params.paketId;

        const membership = await gymMembershipService.createMembership({name, email}, gymId, paketId);
        return createdResponse(res, membership);
    }


    async update(req, res){
        const paketId = req.params.paketId;
        const membershipId = req.params.membershipId;
        const membership = await gymMembershipService.updateMembership(membershipId, paketId);
        return successResponse(res, membership);
    }
    
    async delete(req, res){
        const membershipId = req.params.membershipId;
        const membership = await gymMembershipService.removeMembership(membershipId)

        return successResponse(res, membership);

    }
}

export default new GymMembershipController();