import { ItemModel } from "../models/item.model";
import { SkillModel } from "../models/skill.model";
import { ItemViewModel } from "../view-models/item.viewmodel";
import { SkillViewModel } from "../view-models/skill.viewmodel";
import { readFile } from "./read-file.service";

const config = require('config');

class LookupDataService {
    private readonly localCache: Record<string, any> = [];

    public getRaces() : ItemViewModel[] {
        return this.getFromFileOrCache('races', (model: ItemModel) => model as ItemViewModel);
    }

    public getFactions() : ItemViewModel[] {   
        return this.getFromFileOrCache('factions', (model: ItemModel) => model as ItemViewModel);
    }

    public getEras() : ItemViewModel[] {   
        return this.getFromFileOrCache('eras', (model: ItemModel) => model as ItemViewModel);
    }

    public getTalentsFlaws() : ItemViewModel[] {   
        return this.getFromFileOrCache('talents_flaws', (model: ItemModel) => model as ItemViewModel);
    }

    public getSkills() : SkillViewModel[] {   
        return this.getFromFileOrCache('skills', (model: SkillModel) => model as SkillViewModel);
    }

    public getItems() : ItemViewModel[] {   
        return this.getFromFileOrCache('items', (model: ItemModel) => model as ItemViewModel);
    }

    public getAbilities() : ItemViewModel[] {   
        return this.getFromFileOrCache('abilities', (model: ItemModel) => model as ItemViewModel);
    }

    public getEffects() : ItemViewModel[] {   
        return this.getFromFileOrCache('effects', (model: ItemModel) => model as ItemViewModel);
    }

    private getFromFileOrCache<TModel, TViewModel>(lookupSetName: string, builder: (model: TModel) => TViewModel): TViewModel[] {
        if (this.localCache[`lookup_${lookupSetName}`] === undefined) {
            console.log(`cache miss: ${lookupSetName}`);
            this.localCache[`lookup_${lookupSetName}`] = this.getLookupDataFromFile(lookupSetName, builder);
        }

        return this.localCache[`lookup_${lookupSetName}`] as TViewModel[];
    }

    private getLookupDataFromFile<TModel, TViewModel>(lookupSetName: string, builder: (model: TModel) => TViewModel): TViewModel[] {
        let json = readFile(`${config.get("dataFileRoot")}${lookupSetName}.json`);
        return json.map((x: any) => builder(x)) as TViewModel[];
    }
}

export const LookupDataServiceSingleton = new LookupDataService();