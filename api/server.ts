const express = require('express');
const { auth } = require('express-oauth2-jwt-bearer');
import { router } from './router';

const app = express();
const config = require('config');

app.use(express.json());
app.use(express.static('public'));

app.use(auth({
    audience: config.get('oauth.audience'),
    issuerBaseURL: config.get('oauth.baseUrl'),
    tokenSigningAlg: config.get('oauth.algorithm')
}));

app.use('/', router);
  
app.listen(config.get('port'), function() {
    console.log(`Server started on port ${config.get('port')}`);
});