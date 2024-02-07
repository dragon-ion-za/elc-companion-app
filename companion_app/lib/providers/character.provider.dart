import 'package:elc_companion_app/models/character.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterNotifier extends StateNotifier<Character> {
  CharacterNotifier(this._ref) : super(Character.empty());

  final Ref _ref;

  void updateCharacterStats({String? name, String? bio, String? raceId, String? factionId, String? eraId}) {
    state = Character(state.id, name ?? state.name, bio ?? state.bio, raceId ?? state.raceId, factionId ?? state.factionId, eraId ?? state.eraId, state.talentIds, state.equipmentIds, state.skillIds);
  }

  num getTalentPoints() {
    final talentsFlaws = _ref.read(lookupCacheProvider).value!.talentsFlaws;
    final selectedTalents = talentsFlaws.where((x) => state.talentIds.contains(x.id)).toList();
    num talentPoints = 2;

    for (var selectedTalent in selectedTalents) {
      talentPoints -= selectedTalent.score;
    }

    return talentPoints;
  }

  num getRequisitionPoints() {
    final items = _ref.read(lookupCacheProvider).value!.items;
    final selectedItems = items.where((x) => state.equipmentIds.contains(x.id)).toList();
    num requisitionPoints = 10;

    for (var selectedItem in selectedItems) {
      requisitionPoints -= selectedItem.cost;
    }

    return requisitionPoints;
  }
}

final characterProvider = StateNotifierProvider<CharacterNotifier, Character?>(
    (ref) => CharacterNotifier(ref));