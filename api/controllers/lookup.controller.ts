import config from "config";
import { readFile } from "../services/read-file.service";
import { LookupViewModel } from "../view-models/lookup.viewmodel";

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

    private getLookupDate = (lookupSetName: string): LookupViewModel[] => {
        let json = readFile(`${config.get("dataFileRoot")}${lookupSetName}.json`);
        return json.lookup.map((x: any) => new LookupViewModel(x.id, x.name, x.score ?? 0)) as LookupViewModel[];
    }
}