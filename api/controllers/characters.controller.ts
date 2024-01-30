import { CharacterBuilder } from '../builders/character.builder';
import { CharacterModel } from '../models/character.model';
import { CharacterViewModel } from '../view-models/character.viewmodel';
import { GuardedBaseController } from './guarded.controller';

export class CharactersController extends GuardedBaseController<CharacterModel, CharacterViewModel> {
    constructor() {
        super('Characters', (model: CharacterModel) => CharacterBuilder.buildFromModel(model));        
    }
}