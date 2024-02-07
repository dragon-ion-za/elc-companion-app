import { ItemModel } from "../models/item.model";
import { ItemViewModel } from "../view-models/item.viewmodel";

export class ItemBuilder {
    static buildFromModel(model: ItemModel): ItemViewModel {

        return model as ItemViewModel;
    }
}
