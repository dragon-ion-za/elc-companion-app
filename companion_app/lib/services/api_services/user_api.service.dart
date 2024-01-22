import 'dart:convert';

import 'package:elc_companion_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  String get _baseUrl => '';

  Future<User?> getUser(String id) async {
    final url = Uri.http(_baseUrl, '');
    final response = await http.get(url);

    if (response.statusCode == 404) {
      return null;
    }

    final rawUser = json.decode(response.body);

    return User(rawUser['username'], rawUser['id']);
  }
}
