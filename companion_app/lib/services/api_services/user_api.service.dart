import 'dart:convert';

import 'package:elc_companion_app/models/user.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  UserApiService(this._accessToken);

  final String _accessToken;

  String get _baseUrl => GlobalConfiguration().getValue('apiUrl');

  Map<String, String> get _headers => {'Authorization': 'Bearer $_accessToken', 'Content-Type': 'application/json'};

  Future<User?> getUser(String id) async {
    final url = Uri.http(_baseUrl, 'users/$id');
    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 404) {
      return null;
    }

    final Map<String, dynamic> rawUser = json.decode(response.body);

    if (rawUser.isEmpty) return null;

    return User(rawUser['username'], rawUser['id']);
  }

  Future createUser(User user) async {
    final url = Uri.http(_baseUrl, 'users');
    final response = await http.post(url,
        headers: _headers,
        body: json.encode(user.toJson()));

    if (response.body.isEmpty) {
      throw Exception('Unable to create user. Value returned was null.');
    }
  }
}
