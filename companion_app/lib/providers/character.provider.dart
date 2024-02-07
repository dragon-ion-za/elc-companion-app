import 'package:elc_companion_app/models/character.dart';
import 'package:elc_companion_app/models/equipment.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterNotifier extends StateNotifier<Character> {
  CharacterNotifier(this._ref) : super(Character.empty());

  final Ref _ref;

  void updateCharacterStats({String? name, String? bio, String? raceId, String? factionId, String? eraId}) {
    state = Character(state.id, name ?? state.name, bio ?? state.bio, raceId ?? state.raceId, factionId ?? state.factionId, eraId ?? state.eraId, state.talentIds, state.equipment, state.skillIds);
  }

  void toggleTalent(String talentId, bool value) {
    var talents = state.talentIds;

    if (value) {
        talents.add(talentId);
    } else {
      talents.remove(talentId);
    }

    state = Character(state.id, state.name, state.bio, state.raceId, state.factionId, state.eraId, talents, state.equipment, state.skillIds);
  }

  void updateEquipment(String itemId, String containerId, String slotId) {
    var equipment = state.equipment;

    if (itemId == '0') {
      equipment = equipment.where((x) => x.containerId != containerId && x.slotId != slotId).toList();
    } else {
      final index = equipment.indexWhere((x) => x.containerId == containerId && x.slotId == slotId);

      if (index == -1) {
        equipment.add(Equipment(itemId, containerId, slotId));
      } else {
        equipment[index] = Equipment(itemId, containerId, slotId);
      }
    }

    state = Character(state.id, state.name, state.bio, state.raceId, state.factionId, state.eraId, state.talentIds, equipment, state.skillIds);
  }

  bool areTalentsValid() {
    return getTalentPoints() == 0;
  }

  bool isEquipmentValid() {
    return getRequisitionPoints() >= 0 && state.equipment.isNotEmpty;
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
    final selectedItems = items.where((x) => state.equipment.any((y) => x.id == y.itemId)).toList();
    num requisitionPoints = 10;

    for (var selectedItem in selectedItems) {
      final costAttribute = selectedItem.attributes.firstWhere((x) => x.type == 'cost');
      requisitionPoints -= costAttribute.value ?? 0;
    }

    return requisitionPoints;
  }
}

final characterProvider = StateNotifierProvider<CharacterNotifier, Character?>(
    (ref) => CharacterNotifier(ref));