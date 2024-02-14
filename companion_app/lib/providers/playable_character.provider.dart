import 'dart:async';

import 'package:elc_companion_app/models/playable_character.dart';
import 'package:elc_companion_app/providers/auth.provider.dart';
import 'package:elc_companion_app/services/api_services/character_api.service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayableCharacterNotifier extends FamilyAsyncNotifier<PlayableCharacter, String> {
  PlayableCharacterNotifier();

  @override
  FutureOr<PlayableCharacter> build(String arg) async {
    await loadById(arg);
    return state.value!;
  }

  Future loadById(String id) async {
    state = const AsyncLoading();

    final accessToken = ref.read(authProvider)!.accessToken;
    state = await AsyncValue.guard(() async {
      final char = await CharacterApiService(accessToken!).getPlayableCharacter(id);

      if (char == null) {
        throw Exception('Character not found.');
      }

      return char;
    });
  }
}

final playableCharacterProvider =
    AsyncNotifierProvider.family<PlayableCharacterNotifier, PlayableCharacter, String>(PlayableCharacterNotifier.new);
