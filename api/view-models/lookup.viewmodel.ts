export class LookupViewModel {
    id: string = '';
    name: string = '';
    blurb: string = '';
    score: number = 0;

    constructor(id: string, name: string, blurb: string, score: number) {
        this.id = id;
        this.name = name;
        this.blurb = blurb;
        this.score = score;
    }
}