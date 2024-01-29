import { EquipableModel } from "./equipable.model";
import { SkillModel } from "./skill.model";

export class CharacterModel {
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