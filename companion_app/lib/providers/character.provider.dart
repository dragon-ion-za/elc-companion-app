import 'package:elc_companion_app/models/character.dart';
import 'package:elc_companion_app/models/equipment.dart';
import 'package:elc_companion_app/models/skill.dart';
import 'package:elc_companion_app/providers/auth.provider.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:elc_companion_app/services/api_services/character_api.service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterNotifier extends StateNotifier<Character> {
  CharacterNotifier(this._ref) : super(Character.empty(_ref.read(lookupCacheProvider).value!.skills.map((e) => Skill(e.id, 0, List<String>.filled(4, ''))).toList()));

  final Ref _ref;

  void updateCharacterStats({String? name, String? bio, String? raceId, String? factionId, String? eraId}) {
    state = Character(state.id, name ?? state.name, bio ?? state.bio, raceId ?? state.raceId, factionId ?? state.factionId, eraId ?? state.eraId, state.talentIds, state.equipment, state.skills);
  }

  void toggleTalent(String talentId, bool value) {
    var talents = state.talentIds;

    if (value) {
        talents.add(talentId);
    } else {
      talents.remove(talentId);
    }

    state = Character(state.id, state.name, state.bio, state.raceId, state.factionId, state.eraId, talents, state.equipment, state.skills);
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

    state = Character(state.id, state.name, state.bio, state.raceId, state.factionId, state.eraId, state.talentIds, equipment, state.skills);
  }

  void updateSkillProgression(String skillId, num skillProgression, List<String> abilityIds) {
    var skills = state.skills;
    final skillIndex = skills.indexWhere((x) => x.id == skillId);

    skills.removeAt(skillIndex);
    skills.insert(skillIndex, Skill(skillId, skillProgression, abilityIds));

    state = Character(state.id, state.name, state.bio, state.raceId, state.factionId, state.eraId, state.talentIds, state.equipment, skills);
  }

  bool areStatsValid() {
    return state.name.isNotEmpty && state.eraId != null && state.raceId != null && state.factionId != null;
  }

  bool areTalentsValid() {
    return getTalentPoints() == 0;
  }

  bool isEquipmentValid() {
    return getRequisitionPoints() >= 0 && state.equipment.isNotEmpty;
  }

  bool areSkillsValid() {
    return getFullyTrainedSkillCount() == 3 || (getFullyTrainedSkillCount() == 2 && getPratiallyTrainedSkillCount() == 2);
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

  num getSkillPoints() {
    num usedSkillPoints = 0;

    for (var skill in state.skills) {
      usedSkillPoints += skill.progression;
    }

    return 24 - usedSkillPoints;
  }

  num getFullyTrainedSkillCount() {
    return state.skills.where((x) => x.progression >= 8).length;
  }

  num getPratiallyTrainedSkillCount() {
    return state.skills.where((x) => x.progression > 0 && x.progression < 8).length;
  }

  Future<bool> save() async {
    final accessToken = _ref.read(authProvider)!.accessToken;
    await CharacterApiService(accessToken!).saveCharacter(state!);
    return true;
  }
}

final characterProvider = StateNotifierProvider<CharacterNotifier, Character?>(
    (ref) => CharacterNotifier(ref));