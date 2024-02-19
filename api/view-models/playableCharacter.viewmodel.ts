import { ActionViewModel } from "./action.viewmodel";
import { EquipableViewModel } from "./equipable.viewmodel";
import { SkillViewModel } from "./skill.viewmodel";
import { SurvivabilityViewModel } from "./survivability.viewmodel";

export class PlayableCharacterViewModel {
    id: string = '';
    userId: string = '';
    name: string = '';
    bio: string = '';
    raceId: string = '';
    factionId: string = '';
    eraId: string = '';
    imageUrl: string = '';
    survivability: SurvivabilityViewModel = new SurvivabilityViewModel();
    accuracy: number = 0;
    talentIds: string[] = [];
    equipment: EquipableViewModel[] = [];
    skills: SkillViewModel[] = [];
    actions: ActionViewModel[] = [];
}