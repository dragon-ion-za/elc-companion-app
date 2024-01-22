import 'package:elc_companion_app/models/user.dart';

class Identity {
  final User user;
  final String provider;
  String token;

  Identity(this.user, this.provider) : token = '';

  Identity.copySetToken(Identity existingUser, String newToken)
      : user = existingUser.user,
        provider = existingUser.provider,
        token = newToken;
}
