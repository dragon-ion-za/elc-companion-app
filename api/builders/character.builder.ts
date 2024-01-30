import { CharacterModel } from "../models/character.model";
import { CharacterViewModel } from "../view-models/character.viewmodel";

export class CharacterBuilder {
    static buildFromModel(model: CharacterModel): CharacterViewModel {
        let viewModel = new CharacterViewModel();
        viewModel.id = model.id;
        viewModel.userId = model.userId;
        viewModel.bio = model.bio;
        viewModel.name = model.name;
        viewModel.imageUrl = '???';

        return viewModel;
    }
}