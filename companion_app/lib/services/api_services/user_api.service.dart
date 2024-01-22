import 'dart:convert';

import 'package:elc_companion_app/models/user.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  String get _baseUrl => GlobalConfiguration().getValue('apiUrl');

  Future<User?> getUser(String id) async {
    final url = Uri.http(_baseUrl, 'users/$id');
    final response = await http.get(url);

    if (response.statusCode == 404) {
      return null;
    }

    final Map<String, dynamic> rawUser = json.decode(response.body);

    if (rawUser.isEmpty) return null;
    
    return User(rawUser['username'], rawUser['id']);
  }
}
