const AUTH0_DOMAIN = String.fromEnvironment('AUTH0_DOMAIN');
const AUTH0_CLIENT_ID = String.fromEnvironment('AUTH0_CLIENT_ID');
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
const BUNDLE_IDENTIFIER = 'ddd.elc.app';
const AUTH0_REDIRECT_URI = '$BUNDLE_IDENTIFIER://login-callback';
const REFRESH_TOKEN_KEY = 'rfs_tkn';
const API_AUDIENCE = 'https://api.elc.co.za';

const ATTRIBUTE_TYPES_NONE = 0;
const ATTRIBUTE_TYPES_SCORE = 1;
const ATTRIBUTE_TYPES_BONUS = 2;
const ATTRIBUTE_TYPES_ACTIVATIONTYPE = 3;
const ATTRIBUTE_TYPES_ACTIVATIONEFFECT = 4;
const ATTRIBUTE_TYPES_RESET = 5;
const ATTRIBUTE_TYPES_RESOURCEPOOL_SKILLMULTIPLIER = 6;
const ATTRIBUTE_TYPES_NUMBEROFTARGETS = 7;
const ATTRIBUTE_TYPES_DURATION = 8;
const ATTRIBUTE_TYPES_ACTIONCOST = 9;
const ATTRIBUTE_TYPES_REQUISITIONCOST = 10;
const ATTRIBUTE_TYPES_SLOT = 11;

const CONTAINER_ROOT = 'root';

class SlotTypes {
  static const main = 'slot_main';
  static const sling = 'slot_sling';
  static const head = 'slot_head';
  static const chest = 'slot_chest';
  static const knife = 'slot_knife';
  static const belt = 'slot_belt';
  static const rig = 'slot_rig';
  static const sidearm = 'slot_sidearm';
}