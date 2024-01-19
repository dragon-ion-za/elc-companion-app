import 'package:elc_companion_app/models/identity.dart';
import 'package:elc_companion_app/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProviderNotifier extends StateNotifier<Identity?> {
  AuthProviderNotifier() : super(null);

  bool get isLoggedIn {
    return state != null;
  }

  void loginUser() async {
    final (String message, bool success, String? idToken, String? accessToken) = await AuthService.instance.login();

    if (!success) {
      throw Exception(message);
    }

    final auth0IdToken = AuthService.instance.parseIdToken(idToken!);
    Identity identity = Identity();
  }

  void updateAccessToken(String accessToken) {
    state = Identity.copySetToken(state!, accessToken);
  }
}

final authProvider = StateProvider((ref) => AuthProviderNotifier());