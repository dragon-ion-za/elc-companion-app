import { AttributeViewModel } from "./attribute.viewmodel";

export class AbilityViewModel {
    id: string = '';
    name: string = '';
    description: string = '';
    isElite: boolean = false;
    attributes: AttributeViewModel[] = [];
}