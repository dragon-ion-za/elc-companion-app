import 'dart:convert';
import 'package:elc_companion_app/helpers/constants.dart';
import 'package:elc_companion_app/models/auth/auth0_id_token.dart';
import 'package:elc_companion_app/models/auth/auth0_user.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final AuthService instance = AuthService._internal();

  factory AuthService() => instance;
  AuthService._internal();

  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Auth0User? profile;
  Auth0IdToken? idToken;
  String? auth0AccessToken;

  Future<(String message, bool success, String? idToken, String? accessToken)> login() async {
    try {
      final storedRefreshToken =
        await _secureStorage.read(key: REFRESH_TOKEN_KEY);

      TokenResponse? result;
      if (storedRefreshToken == null) {
        result = await _doLogin();
      } else {
        result = await _doRefresh(storedRefreshToken);
      }

      if (await _handleLoginResult(result)) {
        return ('Logged in.', true, result!.idToken, result.accessToken);
      } else {
        return ('Login result invalid.', false, null, null);
      }
    } on PlatformException {
      return ('User has cancelled or no internet!', false, null, null);
    } catch (e, s) {
      print('error on Refresh Token: $e - stack: $s');
      return ('Unkown Error!', false, null, null);
    }
  }

  Future<AuthorizationTokenResponse?> _doLogin() async {
    final authorizationTokenRequest = AuthorizationTokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        scopes: ['openid', 'profile', 'offline_access', 'email'],
      );

      return await _appAuth.authorizeAndExchangeCode(
        authorizationTokenRequest,
      );
  }

  Future<TokenResponse?> _doRefresh(String refreshToken) async {
    return await _appAuth.token(
        TokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
          issuer: AUTH0_ISSUER,
          refreshToken: refreshToken,
        ),
      );
  }

  Auth0IdToken parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    final Map<String, dynamic> json = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

    return Auth0IdToken.fromJson(json);
  }

  Future<Auth0User> getUserDetails(String accessToken) async {
    final url = Uri.https(
      AUTH0_DOMAIN,
      '/userinfo',
    );

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return Auth0User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<bool> _handleLoginResult(result) async {
    final bool isValidResult =
        result != null && result.accessToken != null && result.idToken != null;

    if (isValidResult) {
      if (result.refreshToken != null) {
        await _secureStorage.write(
          key: REFRESH_TOKEN_KEY,
          value: result.refreshToken,
        );
      }
    }

    return isValidResult;
  }
}
