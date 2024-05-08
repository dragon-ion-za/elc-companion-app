import { ObjectId } from "mongodb";
import { EquipableModel } from "./equipable.model";
import { IBaseModel } from "./model.interface";
import { SkillModel } from "./skill.model";
import { SurvivabilityModel } from "./survivability.model";
import { CharacterDetailsModel } from "./characterDetails.model";

export class CharacterModel implements IBaseModel {

    _id: ObjectId;
    userId: string = '';

    factionId: string = '';
    eraId: string = '';

    details: CharacterDetailsModel = new CharacterDetailsModel();
    survivability: SurvivabilityModel = new SurvivabilityModel();
    talentIds: string[] = [];
    equipment: EquipableModel[] = [];
    skills: SkillModel[] = [];

    constructor(id: ObjectId) {
        this._id = id;
    }
}