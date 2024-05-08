import { AttributeTypes } from "../constants/attributeTypes.enum";

export class AttributeModel {
    type: AttributeTypes = 0;
    targetId: string = '';
    value: string = '';
}