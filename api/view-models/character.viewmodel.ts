import { CharacterDetailsViewModel } from "./characterDetails.viewmodel";
import { EquipableViewModel } from "./equipable.viewmodel";
import { SkillViewModel } from "./skill.viewmodel";
import { SurvivabilityViewModel } from "./survivability.viewmodel";

export class CharacterViewModel {
    id: string = '';
    userId: string = '';
    
    factionId: string = '';
    eraId: string = '';

    details: CharacterDetailsViewModel = new CharacterDetailsViewModel();
    survivability: SurvivabilityViewModel = new SurvivabilityViewModel();
    talentIds: string[] = [];
    equipment: EquipableViewModel[] = [];
    skills: SkillViewModel[] = [];
}