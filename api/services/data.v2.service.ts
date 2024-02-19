import * as mongoDB from 'mongodb';

const config = require('config');

export class DataService<TCollectionModel extends Document> {
    private readonly DB_NAME: string = 'elc_data';
    private dbUrl: string = config.get('connectionStrings.elcContext');
    private mongoClient: mongoDB.MongoClient = new mongoDB.MongoClient(this.dbUrl);
    private collection?: mongoDB.Collection<TCollectionModel>;
    private readonly collectionName: string;

    constructor(collectionName: string) {
        this.collectionName = collectionName;
    }

    public async queryData(filter: mongoDB.Filter<TCollectionModel>) : Promise<TCollectionModel[]> {
        await this.connectToDb();
        return (await this.collection?.find({...filter}).toArray()) as TCollectionModel[];
    }

    public async getById(id: string) : Promise<TCollectionModel> {
        await this.connectToDb();
        return (await this.collection?.findOne({ _id: new Object(id) })) as TCollectionModel;
    }

    private async connectToDb() {
        await this.mongoClient.connect();
        const db: mongoDB.Db = this.mongoClient.db(this.DB_NAME);
        this.collection = db.collection<TCollectionModel>(this.collectionName);
    }
}