import { CharacterBuilder } from '../builders/character.builder';
import { CharacterModel } from '../models/character.model';
import { DataService } from '../services/data.service';
import { CharacterViewModel } from '../view-models/character.viewmodel';
import { BaseController } from './base.controller';

export class CharactersController extends BaseController<CharacterModel, CharacterViewModel> {
    protected override async doSave(model: CharacterModel): Promise<string> {
        throw new Error('Method not implemented.');
    }
    protected doUpdate(model: CharacterModel): Promise<string> {
        throw new Error('Method not implemented.');
    }
    protected override async doGet(): Promise<CharacterViewModel[]> {
        let characters = await DataService.getCharacters();

        let list: CharacterViewModel[] = [];

        characters.forEach((x) => {
            list.push(CharacterBuilder.buildFromModel(x));
        });

        return list;
    }
    protected override async doGetById(id: string): Promise<CharacterViewModel> {
        throw new Error('Method not implemented.');
    }
}