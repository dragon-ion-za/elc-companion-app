export class SkillModel {
    id: string = '';
    progression: number = 0;
    abilities: Map<string, number> = new Map<string, number>();
}