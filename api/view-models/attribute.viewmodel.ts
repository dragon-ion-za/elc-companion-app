import { AttributeTypes } from "../constants/attributeTypes.enum";

export class AttributeViewModel {
    type: AttributeTypes = 0;
    targetId: string = '';
    value: string = '';
}