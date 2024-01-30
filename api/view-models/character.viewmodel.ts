import { SurvivabilityViewModel } from "./survivability.viewmodel";
import { TalentViewModel } from "./talent.viewmodel";

export class CharacterViewModel {
    id: string = '';
    userId: string = '';
    name: string = '';
    bio: string = '';
    imageUrl: string = '';
    hitPoints: SurvivabilityViewModel = new SurvivabilityViewModel();
    talents: TalentViewModel[] = [];
}