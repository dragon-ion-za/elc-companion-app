import config from "config";
import { readFile } from "../services/read-file.service";
import { LookupViewModel } from "../view-models/lookup.viewmodel";

export class LookupController {
    public getRaces = (req: any, res: any) => {   
        let json = readFile(`${config.get("dataFileRoot")}races.json`);
        let list = json.lookup.map((x: any) => new LookupViewModel(x.name));         
        res.send(list);
    }

    public getFactions = (req: any, res: any) => {   
        let json = readFile(`${config.get("dataFileRoot")}factions.json`);
        let list = json.lookup.map((x: any) => new LookupViewModel(x.name));         
        res.send(list);
    }
}