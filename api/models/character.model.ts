import { EquipableModel } from "./equipable.model";
import { IBaseModel } from "./model.interface";
import { SkillModel } from "./skill.model";

export class CharacterModel extends Document implements IBaseModel {
    id: string = '';
    userId: string = '';
    name: string = '';
    talentIds: string[] = [];
    flawIds: string[] = [];
    skills: SkillModel[] = [];
    equipment: EquipableModel[] = [];
    inventoryIds: string[] = [];
    bio: string = '';
    imageId: string = '';
}