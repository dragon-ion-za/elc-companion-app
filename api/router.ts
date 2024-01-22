import { UsersController } from './controllers/users.controller';

const express = require('express');

export const router = express.Router();

router.get('/users/:id', new UsersController().getById);