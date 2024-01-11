import 'dart:convert';

import 'package:elc_companion_app/helpers/constants.dart';
import 'package:elc_companion_app/models/auth/auth0_id_token.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();

  factory AuthService() => instance;
  AuthService._internal();

  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  login() async {
    final authTokenRequest = AuthorizationTokenRequest(AUTH0_CLIENT_ID, AUTH0_REDIRECT_URI,
    issuer: AUTH0_ISSUE,
    scopes: ['openid', 'offline_access']);

    final AuthorizationTokenResponse? result = await appAuth.authorizeAndExchangeCode(authTokenRequest);
  }

  Auth0IdToken parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    final Map<String, dynamic> json = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

    return Auth0IdToken.fromJson(json);
  }
}