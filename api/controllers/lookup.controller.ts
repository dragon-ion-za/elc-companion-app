import config from "config";
import { readFile } from "../services/read-file.service";
import { LookupViewModel } from "../view-models/lookup.viewmodel";
import { ItemModel } from "../models/item.model";
import { ItemViewModel } from "../view-models/item.viewmodel";
import { ItemBuilder } from "../builders/items.builder";

export class LookupController {
    public getRaces = (req: any, res: any) => {   
        res.send(this.getLookupDate('races'));
    }

    public getFactions = (req: any, res: any) => {   
        res.send(this.getLookupDate('factions'));
    }

    public getEras = (req: any, res: any) => {   
        res.send(this.getLookupDate('eras'));
    }

    public getTalentsFlaws = (req: any, res: any) => {   
        res.send(this.getLookupDate('talents_flaws'));
    }

    public getSkills = (req: any, res: any) => {         
        res.send(this.getLookupDate('skills'));
    }

    public getItems = (req: any, res: any) => {         
        res.send(this.getLookupData<ItemModel, ItemViewModel>('items', (model: ItemModel) => ItemBuilder.buildFromModel(model)));
    }

    private getLookupDate = (lookupSetName: string): LookupViewModel[] => {
        let json = readFile(`${config.get("dataFileRoot")}${lookupSetName}.json`);
        return json.lookup.map((x: any) => new LookupViewModel(x.id, x.name, x.score ?? 0)) as LookupViewModel[];
    }

    private getLookupData = <TModel, TViewModel>(lookupSetName: string, builder: (model: TModel) => TViewModel): TViewModel[] => {
        let json = readFile(`${config.get("dataFileRoot")}${lookupSetName}.json`);
        return json.map((x: any) => builder(x)) as TViewModel[];
    }
}