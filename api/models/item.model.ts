import { AttributeModel } from "./attribute.model";

export class ItemModel {
    id: string = '';
    name: string = '';
    blurb: string = '';
    description: string = '';
    attributes: AttributeModel[] = [];
    tags: string[] = [];
}