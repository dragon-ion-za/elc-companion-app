export class AttributeModel {
    type: AttributeTypes = 0;
    targetId: string = '';
    value: string = '';
}

export enum AttributeTypes {
    None = 0,
    Score = 1,
    Bonus = 2,
    ActivationType = 3,
    ActivationEffect = 4,
    Reset = 5,
    ResourcePool_SkillMultiplier = 6,
    NumberOfTargets = 7,
    Duration = 8,
    ActionCost = 9
}