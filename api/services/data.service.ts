import * as mongoDB from 'mongodb';
import { UserModel } from '../models/user.model';

const config = require('config');

export class DataService {
    private static dbUrl: string = config.get('connectionStrings.elcContext');
    private static mongoClient: mongoDB.MongoClient = new mongoDB.MongoClient(this.dbUrl);
    private static collections: {
        users?: mongoDB.Collection<UserModel>,
    } = {};

    private static async connectToDb() {
        await this.mongoClient.connect();
        const db: mongoDB.Db = this.mongoClient.db('elc_data');
        this.collections.users = db.collection<UserModel>('Users');
    }

    public static async getUserById(id: string): Promise<UserModel> {
        await this.connectToDb();
        let user = (await this.collections.users?.findOne({ id: id })) as UserModel;

        return user;
    }
}