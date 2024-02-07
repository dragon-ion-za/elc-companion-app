import 'dart:convert';

import 'package:elc_companion_app/models/character.dart';
import 'package:elc_companion_app/services/api_services/base.service.dart';
import 'package:http/http.dart' as http;

class CharacterApiService extends BaseApiService {
  CharacterApiService(super._accessToken);

  final String _apiBaseUrl = 'characters/';

  Future<Character?> getCharacter(String id) async {
    final url = Uri.http(super.baseUrl, '$_apiBaseUrl$id');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 404) {
      return null;
    }

    final Map<String, dynamic> rawCharacter = json.decode(response.body);

    if (rawCharacter.isEmpty) return null;

    return Character.fromJson(rawCharacter);
  }
  
  Future<List<Character>> getCharacters() async {
    final url = Uri.http(super.baseUrl, _apiBaseUrl);
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 404) {
      return [];
    }

    final List<dynamic> list = json.decode(response.body);

    if (list.isEmpty) return [];

    final List<Character> characters = [];
    for(final character in list) {
      characters.add(Character.fromJson(character));
    }
    
    return characters;
  }
}
