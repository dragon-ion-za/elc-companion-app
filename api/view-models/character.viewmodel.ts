import { EquipableViewModel } from "./equipable.viewmodel";
import { SkillViewModel } from "./skill.viewmodel";
import { SurvivabilityViewModel } from "./survivability.viewmodel";

export class CharacterViewModel {
    id: string = '';
    userId: string = '';
    name: string = '';
    bio: string = '';
    raceId: string = '';
    factionId: string = '';
    eraId: string = '';
    imageUrl: string = '';
    survivability: SurvivabilityViewModel = new SurvivabilityViewModel();
    talentIds: string[] = [];
    equipment: EquipableViewModel[] = [];
    skills: SkillViewModel[] = [];
}