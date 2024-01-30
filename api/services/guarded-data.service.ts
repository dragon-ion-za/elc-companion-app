import * as mongoDB from 'mongodb';

const config = require('config');

export class GuardedDataService<TCollectionModel extends Document> {
    private readonly DB_NAME: string = 'elc_data';
    private dbUrl: string = config.get('connectionStrings.elcContext');
    private mongoClient: mongoDB.MongoClient = new mongoDB.MongoClient(this.dbUrl);
    private collection?: mongoDB.Collection<TCollectionModel>;
    private readonly collectionName: string;
    private readonly userId: string;

    constructor(collectionName: string, userId: string) {
        this.collectionName = collectionName;
        this.userId = userId;
    }

    public async queryData(filter: mongoDB.Filter<TCollectionModel>) : Promise<TCollectionModel[]> {
        await this.connectToDb();
        return (await this.collection?.find({...filter, userId: this.userId}).toArray()) as TCollectionModel[];
    }

    private async connectToDb() {
        await this.mongoClient.connect();
        const db: mongoDB.Db = this.mongoClient.db(this.DB_NAME);
        this.collection = db.collection<TCollectionModel>(this.collectionName);
    }
}