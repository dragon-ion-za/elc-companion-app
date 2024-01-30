import * as mongoDB from 'mongodb';
import { UserModel } from '../models/user.model';
import { CharacterModel } from '../models/character.model';

const config = require('config');

export class DataService {
    private static dbUrl: string = config.get('connectionStrings.elcContext');
    private static mongoClient: mongoDB.MongoClient = new mongoDB.MongoClient(this.dbUrl);
    private static collections: {
        users?: mongoDB.Collection<UserModel>,
        characters?: mongoDB.Collection<CharacterModel>
    } = {};

    private static async connectToDb() {
        await this.mongoClient.connect();
        const db: mongoDB.Db = this.mongoClient.db('elc_data');
        this.collections.users = db.collection<UserModel>('Users');
        this.collections.characters = db.collection<CharacterModel>('Characters');
    }

    public static async saveUser(user: UserModel) : Promise<string> {
        await this.connectToDb();
        console.log(user);
        let result = await this.collections.users?.insertOne(user);
        
        if (result?.acknowledged) {
            return user.id;
        } else {
            throw 'Unable to insert user.';
        }
    }

    public static async getUserById(id: string): Promise<UserModel> {
        await this.connectToDb();
        let user = (await this.collections.users?.findOne({ id: id })) as UserModel;

        return user;
    }

    public static async getCharacters(): Promise<CharacterModel[]> {
        await this.connectToDb();
        return (await this.collections.characters?.find({}).toArray()) as CharacterModel[];
    }
}