import { CharacterBuilder } from '../builders/character.builder';
import { CharacterModel } from '../models/character.model';
import { CharacterViewModel } from '../view-models/character.viewmodel';
import { GuardedBaseController } from './guarded.controller';

export class CharactersController extends GuardedBaseController<CharacterModel, CharacterViewModel> {
    constructor() {
        super('Characters', (model: CharacterModel) => CharacterBuilder.buildFromModel(model), (viewModel: CharacterViewModel) => CharacterBuilder.buildFromViewModel(viewModel));        
    }

    public getPlayableCharacterById = async (req: any, res: any, next: any) => {
        try {
            if (this.dataService == null) this.initDataService(req.auth.payload.sub);
            let id: string = req.params.id;
            let data: CharacterModel = await this.dataService!.getById(id);
            
            res.send(CharacterBuilder.playbleFromModel(data));
        }
        catch (err) {
            next(err);
        }
    }
}