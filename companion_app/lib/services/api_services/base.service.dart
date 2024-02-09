import 'package:global_configuration/global_configuration.dart';

abstract class BaseApiService {
  BaseApiService(this._accessToken);

  final String _accessToken;
  String get baseUrl => GlobalConfiguration().getValue('apiUrl');
  Map<String, String> get headers => {'Authorization': 'Bearer $_accessToken', 'Content-Type': 'application/json'};
}