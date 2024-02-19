import 'package:elc_companion_app/models/identity.dart';
import 'package:elc_companion_app/models/user.dart';
import 'package:elc_companion_app/services/api_services/user_api.service.dart';
import 'package:elc_companion_app/services/auth_service.dart';
import 'package:elc_companion_app/services/auth_service_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoginStatus { loggedIn, newUser, loggedOut }

class AuthProviderNotifier extends StateNotifier<Identity?> {
  AuthProviderNotifier() : super(null);

  bool get isLoggedIn {
    return state != null;
  }

  Future<LoginStatus> loginUser() async {
    final (String message, bool success, String? idToken, String? accessToken) =
        kIsWeb
            ? await AuthServiceWeb.instance.login()
            : await AuthService.instance.login();

    if (!success) {
      throw Exception(message);
    }

    final auth0IdToken = AuthService.instance.parseIdToken(idToken!);

    User? user =
        await UserApiService(accessToken!).getUser(auth0IdToken.userId);

    Identity identity = Identity(user);
    identity.accessToken = accessToken;
    identity.idToken = idToken;

    state = identity;

    if (user == null) {
      return LoginStatus.newUser;
    }

    return LoginStatus.loggedIn;
  }

  Future<bool> registerUser(String username) async {
    if (state == null) throw Exception('Auth state is NULL!');

    final auth0IdToken = AuthService.instance.parseIdToken(state!.idToken!);
    final apiClient = UserApiService(state!.accessToken!);
    await apiClient.createUser(User(username, auth0IdToken.userId));
    User? user = await apiClient.getUser(auth0IdToken.userId);
    state = Identity.copyWith(user!, state!.accessToken!, state!.idToken!);

    return true;
  }
}

final authProvider = StateNotifierProvider<AuthProviderNotifier, Identity?>(
    (ref) => AuthProviderNotifier());
