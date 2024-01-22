import 'package:elc_companion_app/models/user.dart';

class Identity {
  final User? user;
  String? accessToken;
  String? idToken;

  Identity(this.user, {this.accessToken, this.idToken});

  Identity.withTokens(String overrideAccessToken, String overrideIdToken)
      : user = null,
        accessToken = overrideAccessToken,
        idToken = overrideIdToken;

  Identity.copyWith(
      User overrideUser, String overrideAccessToken, String overrideIdToken)
      : user = overrideUser,
        accessToken = overrideAccessToken,
        idToken = overrideIdToken;
}
