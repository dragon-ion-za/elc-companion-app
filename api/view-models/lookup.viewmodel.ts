export class LookupViewModel {
    id: string = '';
    name: string = '';
    score: number = 0;

    constructor(id: string, name: string, score: number) {
        this.id = id;
        this.name = name;
        this.score = score;
    }
}