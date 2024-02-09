import { AttributeViewModel } from "./attribute.viewmodel";
import { ContainerViewModel } from "./container.viewmodel";

export class ItemViewModel {
    id: string = '';
    name: string = '';
    description: string = '';
    attributes: AttributeViewModel[] = [];
    containers: ContainerViewModel[] = [];
}