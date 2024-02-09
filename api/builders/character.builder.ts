import { ObjectId } from "mongodb";
import { CharacterModel } from "../models/character.model";
import { CharacterViewModel } from "../view-models/character.viewmodel";

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
        viewModel.hitPoints = model.hitPoints;
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
        model.hitPoints = viewModel.hitPoints;
        model.skills = viewModel.skills;
        model.talentIds = viewModel.talentIds;
        model.equipment = viewModel.equipment;

        return model;
    }
}