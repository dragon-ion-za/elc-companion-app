import { AttributeModel } from "./attribute.model";

export class AbilityModel {
    id: string = '';
    name: string = '';
    description: string = '';
    isElite: boolean = false;
    attributes: AttributeModel[] = [];
}