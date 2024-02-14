import { LookupDataServiceSingleton } from "../services/lookupData.service";

export class LookupController {
    public getRaces = (req: any, res: any) => {   
        res.send(LookupDataServiceSingleton.getRaces());
    }

    public getFactions = (req: any, res: any) => {   
        res.send(LookupDataServiceSingleton.getFactions());
    }

    public getEras = (req: any, res: any) => {   
        res.send(LookupDataServiceSingleton.getEras());
    }

    public getTalentsFlaws = (req: any, res: any) => {   
        res.send(LookupDataServiceSingleton.getTalentsFlaws());
    }

    public getSkills = (req: any, res: any) => {         
        res.send(LookupDataServiceSingleton.getSkills());
    }

    public getItems = (req: any, res: any) => {         
        res.send(LookupDataServiceSingleton.getItems());
    }

    public getAbilities = (req: any, res: any) => {         
        res.send(LookupDataServiceSingleton.getAbilities());
    }
}