import { ObjectId } from "mongodb";

export interface IBaseModel {
    _id: ObjectId;
    userId: string;
}