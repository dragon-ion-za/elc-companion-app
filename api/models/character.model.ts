import { ObjectId, Document as MongoDoc, WithId } from "mongodb";
import { EquipableModel } from "./equipable.model";
import { IBaseModel } from "./model.interface";
import { SkillModel } from "./skill.model";
import { SurvivabilityModel } from "./survivability.model";

export class CharacterModel implements IBaseModel {
    _id: ObjectId;
    userId: string = '';
    
    name: string = '';
    bio: string = '';
    raceId: string = '';
    factionId: string = '';
    eraId: string = '';
    imageUrl: string = '';
    survivability: SurvivabilityModel = new SurvivabilityModel();
    talentIds: string[] = [];
    equipment: EquipableModel[] = [];
    skills: SkillModel[] = [];

    constructor(id: ObjectId) {
        this._id = id;
    }
}