import 'dart:async';

import 'package:elc_companion_app/models/character.dart';
import 'package:elc_companion_app/providers/auth.provider.dart';
import 'package:elc_companion_app/services/api_services/character_api.service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterListProviderNotifier extends AsyncNotifier<List<Character>> {
  CharacterListProviderNotifier();

  @override
  FutureOr<List<Character>> build() async {
    await loadList();
    return state.value!;
  }

  Future loadList() async {
    state = const AsyncLoading();

    final accessToken = ref.read(authProvider)!.accessToken;
    state = await AsyncValue.guard(
        () async => await CharacterApiService(accessToken!).getCharacters());
  }
}

final characterListProvider =
    AsyncNotifierProvider<CharacterListProviderNotifier, List<Character>>(
        CharacterListProviderNotifier.new);
