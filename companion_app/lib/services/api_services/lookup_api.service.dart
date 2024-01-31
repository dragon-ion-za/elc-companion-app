import 'dart:convert';

import 'package:elc_companion_app/models/lookup.dart';
import 'package:elc_companion_app/services/api_services/base.service.dart';
import 'package:http/http.dart' as http;

class LookupApiService extends BaseApiService {
  LookupApiService(super._accessToken);

  final String _apiBaseUrl = 'lookup/';

  Future<List<Lookup>> getRaces() async {
    final url = Uri.http(super.baseUrl, '${_apiBaseUrl}races');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 404) {
      return [];
    }

    final List<dynamic> list = json.decode(response.body);

    if (list.isEmpty) return [];

    final List<Lookup> races = [];
    for(final race in list) {
      races.add(Lookup.fromJson(race));
    }
    
    return races;
  }

  Future<List<Lookup>> getFactions() async {
    final url = Uri.http(super.baseUrl, '${_apiBaseUrl}factions');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 404) {
      return [];
    }

    final List<dynamic> list = json.decode(response.body);

    if (list.isEmpty) return [];

    final List<Lookup> factions = [];
    for(final faction in list) {
      factions.add(Lookup.fromJson(faction));
    }
    
    return factions;
  }
}