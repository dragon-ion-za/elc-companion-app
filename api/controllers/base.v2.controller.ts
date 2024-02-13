import { DataService } from "../services/data.v2.service";

export abstract class BaseController<TModel extends Document, TViewModel> { 
    protected dataService?: DataService<TModel>;
    private readonly collectionName: string;
    private readonly toViewModel: (model: TModel) => TViewModel;

    protected constructor(collectionName: string, viewModelConverter: (model: TModel) => TViewModel) {
        this.collectionName = collectionName;
        this.toViewModel = viewModelConverter;
    }

    public get = async (req: any, res: any, next: any) => {
        try {
            if (this.dataService == null) this.initDataService();

            let data: TModel[] = await this.dataService!.queryData({});
            let viewData: TViewModel[] = [];
            data.forEach((element) => viewData.push(this.toViewModel(element)));

            res.send(viewData);
        }
        catch (err) {
            next(err);
        }
    }

    public getById = async (req: any, res: any, next: any) => {
        try {
            if (this.dataService == null) this.initDataService();
            let id: string = req.params.id;
            let data: TModel = await this.dataService!.getById(id);

            res.send(this.toViewModel(data));
        }
        catch (err) {
            next(err);
        }
    }

    private initDataService() {
        this.dataService = new DataService(this.collectionName);
    }
}