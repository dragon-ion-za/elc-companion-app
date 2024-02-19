import { ObjectId } from "mongodb";
import { CharacterModel } from "../models/character.model";
import { CharacterViewModel } from "../view-models/character.viewmodel";
import { PlayableCharacterViewModel } from "../view-models/playableCharacter.viewmodel";
import { SurvivabilityViewModel } from "../view-models/survivability.viewmodel";
import { CharacterRulesEngineSingleton } from "../rules/character.rules";

export class CharacterBuilder {
    static buildFromModel(model: CharacterModel): CharacterViewModel {
        let viewModel = new CharacterViewModel();
        viewModel.id = model._id.toString();
        viewModel.userId = model.userId;

        viewModel.name = model.name;
        viewModel.bio = model.bio;
        viewModel.raceId = model.raceId;
        viewModel.factionId = model.factionId;
        viewModel.eraId = model.eraId;
        viewModel.survivability = model.survivability;
        viewModel.skills = model.skills;
        viewModel.talentIds = model.talentIds;
        viewModel.equipment = model.equipment;
        viewModel.imageUrl = '???';

        return viewModel;
    }

    static buildFromViewModel(viewModel: CharacterViewModel): CharacterModel {
        let model = new CharacterModel(viewModel.id != null && viewModel.id.length > 0 ? ObjectId.createFromHexString(viewModel.id) : new ObjectId());
        model.name = viewModel.name;
        model.bio = viewModel.bio;
        model.raceId = viewModel.raceId;
        model.factionId = viewModel.factionId;
        model.eraId = viewModel.eraId;
        model.survivability = viewModel.survivability;
        model.skills = viewModel.skills;
        model.talentIds = viewModel.talentIds;
        model.equipment = viewModel.equipment;

        return model;
    }

    static playbleFromModel(model: CharacterModel): PlayableCharacterViewModel {
        let viewModel = new PlayableCharacterViewModel();
        viewModel.id = model._id.toString();
        viewModel.userId = model.userId;

        viewModel.name = model.name;
        viewModel.bio = model.bio;
        viewModel.raceId = model.raceId;
        viewModel.factionId = model.factionId;
        viewModel.eraId = model.eraId;
        viewModel.survivability = this.buildSurvivability(model);
        viewModel.skills = model.skills;
        viewModel.talentIds = model.talentIds;
        viewModel.equipment = model.equipment;
        viewModel.accuracy = CharacterRulesEngineSingleton.calculateAccuracy(model.skills);
        viewModel.actions = CharacterRulesEngineSingleton.calculateActions(model.equipment, model.skills, viewModel.accuracy)
        viewModel.imageUrl = '???';

        return viewModel;
    }

    private static buildSurvivability(model: CharacterModel) : SurvivabilityViewModel {
        let survivability = new SurvivabilityViewModel();
        survivability.maxHp = CharacterRulesEngineSingleton.calculateHitpoints(model.equipment);
        survivability.mitigationScore = CharacterRulesEngineSingleton.calculateMitigationScore(model.equipment, model.skills);

        survivability.currentHp = model.survivability?.currentHp ?? survivability.maxHp;
        survivability.currentStress = model.survivability?.currentStress ?? 0;
        

        return survivability;
    }
}