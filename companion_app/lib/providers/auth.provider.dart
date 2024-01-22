import 'package:elc_companion_app/models/identity.dart';
import 'package:elc_companion_app/services/api_services/user_api.service.dart';
import 'package:elc_companion_app/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoginStatus {
  loggedIn,
  newUser,
  loggedOut
}

class AuthProviderNotifier extends StateNotifier<Identity?> {
  AuthProviderNotifier() : super(null);

  bool get isLoggedIn {
    return state != null;
  }

  Future<LoginStatus> loginUser() async {
    final (String message, bool success, String? idToken, String? accessToken) = await AuthService.instance.login();

    if (!success) {
      throw Exception(message);
    }

    final auth0IdToken = AuthService.instance.parseIdToken(idToken!);
    final user = await UserApiService().getUser(auth0IdToken.userId);

    if (user == null) {
      return LoginStatus.newUser;
    }

    Identity identity = Identity(user, auth0IdToken.iss);
    identity.token = accessToken!;

    state = identity;

    return LoginStatus.loggedIn;
  }

  void updateAccessToken(String accessToken) {
    state = Identity.copySetToken(state!, accessToken);
  }
}

final authProvider = StateNotifierProvider<AuthProviderNotifier, Identity?>((ref) => AuthProviderNotifier());