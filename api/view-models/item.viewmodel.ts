import { AttributeViewModel } from "./attribute.viewmodel";

export class ItemViewModel {
    id: string = '';
    name: string = '';
    blurb: string = '';
    description: string = '';
    attributes: AttributeViewModel[] = [];
    tags: string[] = [];
}