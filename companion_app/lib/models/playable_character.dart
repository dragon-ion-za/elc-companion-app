import 'package:elc_companion_app/models/equipment.dart';
import 'package:elc_companion_app/models/skill.dart';
import 'package:elc_companion_app/models/survivability.dart';
import 'package:json_annotation/json_annotation.dart';
part 'playable_character.g.dart';

@JsonSerializable()
class PlayableCharacter {
  final String? id;
  final String name;
  final String bio;
  final String? raceId;
  final String? factionId;
  final String? eraId;

  final List<String> talentIds;
  final List<Equipment> equipment;
  final List<Skill> skills;

  final Survivability survivability;

  PlayableCharacter.empty()
      : id = null,
        name = '',
        bio = '',
        raceId = null,
        factionId = null,
        eraId = null,
        talentIds = [],
        equipment = [],
        skills = [],
        survivability = Survivability(0, 0, 0, 0);

  PlayableCharacter(this.id, this.name, this.bio, this.raceId, this.factionId,
      this.eraId, this.talentIds, this.equipment, this.skills, this.survivability);

  factory PlayableCharacter.fromJson(Map<String, dynamic> json) =>
      _$PlayableCharacterFromJson(json);

  Map<String, dynamic> toJson() => _$PlayableCharacterToJson(this);
}
