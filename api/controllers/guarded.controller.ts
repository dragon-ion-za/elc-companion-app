import { ObjectId } from "mongodb";
import { GuardedDataService } from "../services/guarded-data.service";
import { IBaseModel } from "../models/model.interface";

export abstract class GuardedBaseController<TModel extends IBaseModel, TViewModel> { 
    protected dataService?: GuardedDataService<TModel>;
    private readonly collectionName: string;
    private readonly toViewModel: (model: TModel) => TViewModel;
    private readonly toModel: (model: TViewModel) => TModel;

    protected constructor(collectionName: string, viewModelConverter: (model: TModel) => TViewModel, modelConverter: (viewModel: TViewModel) => TModel) {
        this.collectionName = collectionName;
        this.toViewModel = viewModelConverter;
        this.toModel = modelConverter;
    }

    public get = async (req: any, res: any, next: any) => {
        try {
            if (this.dataService == null) this.initDataService(req.auth.payload.sub);

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
            if (this.dataService == null) this.initDataService(req.auth.payload.sub);
            let id: string = req.params.id;
            let data: TModel = await this.dataService!.getById(id);
            
            res.send(this.toViewModel(data));
        }
        catch (err) {
            next(err);
        }
    }

    public post = async (req: any, res: any, next: any) => {
        try {
            if (this.dataService == null) this.initDataService(req.auth.payload.sub);

            let rawData = {...(req.body as TViewModel), _id: new ObjectId()} as TViewModel;
            let data = this.toModel(rawData);
            let result = await this.dataService!.saveData(data);

            res.send(this.toViewModel(result));
        }
        catch (err) {
            next(err);
        }
    }

    protected initDataService(userId: string) {
        this.dataService = new GuardedDataService(this.collectionName, userId);
    }
}