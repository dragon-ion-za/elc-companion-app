import { CharactersController } from './controllers/characters.controller';
import { UsersController } from './controllers/users.controller';

const express = require('express');

export const router = express.Router();

router.post('/users', new UsersController().save);
router.get('/users/:id', new UsersController().getById);

router.get('/characters', new CharactersController().get);