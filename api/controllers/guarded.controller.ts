import { GuardedDataService } from "../services/guarded-data.service";

export abstract class GuardedBaseController<TModel extends Document, TViewModel> { 
    protected dataService?: GuardedDataService<TModel>;
    private readonly collectionName: string;
    private readonly toViewModel: (model: TModel) => TViewModel;

    protected constructor(collectionName: string, viewModelConverter: (model: TModel) => TViewModel) {
        this.collectionName = collectionName;
        this.toViewModel = viewModelConverter;
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

    private initDataService(userId: string) {
        this.dataService = new GuardedDataService(this.collectionName, userId);
    }
}