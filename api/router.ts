import { CharactersController } from './controllers/characters.controller';
import { LookupController } from './controllers/lookup.controller';
import { UsersController } from './controllers/users.controller';

const express = require('express');

export const router = express.Router();

router.post('/users', new UsersController().save);
router.get('/users/:id', new UsersController().getById);

router.get('/characters', new CharactersController().get);
router.post('/characters', new CharactersController().post);

router.get('/lookup/races', new LookupController().getRaces);
router.get('/lookup/factions', new LookupController().getFactions);
router.get('/lookup/eras', new LookupController().getEras);
router.get('/lookup/talentsFlaws', new LookupController().getTalentsFlaws);
router.get('/lookup/items', new LookupController().getItems);
router.get('/lookup/skills', new LookupController().getSkills);
router.get('/lookup/abilities', new LookupController().getAbilities);