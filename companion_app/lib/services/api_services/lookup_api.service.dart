import 'dart:convert';

import 'package:elc_companion_app/models/lookup.dart';
import 'package:elc_companion_app/services/api_services/base.service.dart';
import 'package:http/http.dart' as http;

class LookupApiService extends BaseApiService {
  LookupApiService(super._accessToken);

  final String _apiBaseUrl = 'lookup/';

  Future<List<Lookup>> getRaces() async {
    return await _getLookup('races');
  }

  Future<List<Lookup>> getFactions() async {
    return await _getLookup('factions');
  }

  Future<List<Lookup>> getEras() async {
    return await _getLookup('eras');
  }

  Future<List<Lookup>> getTalentsFlaws() async {
    return await _getLookup('talentsFlaws');
  }

  Future<List<Lookup>> getSkills() async {
    return await _getLookup('skills');
  }

  Future<List<Lookup>> _getLookup(String lookupPath) async {
    final url = Uri.http(super.baseUrl, '${_apiBaseUrl}${lookupPath}');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 404) {
      return [];
    }

    final List<dynamic> list = json.decode(response.body);

    if (list.isEmpty) return [];

    final List<Lookup> lookupList = [];
    for(final lookupItem in list) {
      lookupList.add(Lookup.fromJson(lookupItem));
    }
    
    return lookupList;
  }
}