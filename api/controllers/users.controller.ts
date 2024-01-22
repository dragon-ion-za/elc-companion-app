import { UserModel } from '../models/user.model';
import { DataService } from '../services/data.service';
import { UserViewModel } from '../view-models/user.viewmodel';
import { BaseController } from './base.controller';

export class UsersController extends BaseController<UserModel, UserViewModel> {
    protected override async doSave(model: UserModel): Promise<string> {
        return await DataService.saveUser(model);
    }
    protected doUpdate(model: UserModel): Promise<string> {
        throw new Error('Method not implemented.');
    }
    protected doGet(): Promise<UserViewModel[]> {
        throw new Error('Method not implemented.');
    }
    protected override async doGetById(id: string): Promise<UserViewModel> {
        let user: UserModel = await DataService.getUserById(id);
        let viewModel: UserViewModel = { ...user };
        return viewModel;
    }
}