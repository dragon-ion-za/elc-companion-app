import 'dart:async';

import 'package:elc_companion_app/models/playable_character.dart';
import 'package:elc_companion_app/models/skill.dart';
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

  void incrementSkillProgress(String skillId) {
    var skills = state.value!.skills;
    var skillIndex = state.value!.skills.indexWhere((x) => x.id == skillId);

    skills[skillIndex].progression += 1;

    state = AsyncValue.data(state.value!.copyWith(skills: skills));
  }

  void updateSkillAbilities(String skillId, List<String> abilityIds) {
    var skills = state.value!.skills;
    final skillIndex = skills.indexWhere((x) => x.id == skillId);
    final oldSkill = skills[skillIndex];

    skills.removeAt(skillIndex);
    skills.insert(skillIndex, Skill(skillId, oldSkill.progression, abilityIds));

    state = AsyncValue.data(state.value!.copyWith(skills: skills));
  }
}

final playableCharacterProvider =
    AsyncNotifierProvider.family<PlayableCharacterNotifier, PlayableCharacter, String>(PlayableCharacterNotifier.new);
