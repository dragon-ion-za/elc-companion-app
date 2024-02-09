import { AttributeModel } from "./attribute.model";
import { ContainerModel } from "./container.model";

export class ItemModel {
    id: string = '';
    name: string = '';
    description: string = '';
    attributes: AttributeModel[] = [];
    containers: ContainerModel[] = [];
}