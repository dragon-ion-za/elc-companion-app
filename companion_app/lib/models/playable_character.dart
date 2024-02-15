import 'package:elc_companion_app/models/action.dart';
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
  final num accuracy;

  final List<String> talentIds;
  final List<Equipment> equipment;
  final List<Skill> skills;
  final List<Action> actions;

  final Survivability survivability;

  PlayableCharacter.empty()
      : id = null,
        name = '',
        bio = '',
        raceId = null,
        factionId = null,
        eraId = null,
        accuracy = 0,
        talentIds = [],
        equipment = [],
        skills = [],
        actions = [],
        survivability = Survivability(0, 0, 0, 0);

  PlayableCharacter(
      this.id,
      this.name,
      this.bio,
      this.raceId,
      this.factionId,
      this.eraId,
      this.accuracy,
      this.talentIds,
      this.equipment,
      this.skills,
      this.actions,
      this.survivability);

  PlayableCharacter copyWith(
      {String? id,
      String? name,
      String? bio,
      String? raceId,
      String? factionId,
      String? eraId,
      num? accuracy,
      List<String>? talentIds,
      List<Equipment>? equipment,
      List<Skill>? skills,
      List<Action>? actions,
      Survivability? survivability}) {
    return PlayableCharacter(
        id ?? this.id,
        name ?? this.name,
        bio ?? this.bio,
        raceId ?? this.raceId,
        factionId ?? this.factionId,
        eraId ?? this.eraId,
        accuracy ?? this.accuracy,
        talentIds ?? this.talentIds,
        equipment ?? this.equipment,
        skills ?? this.skills,
        actions ?? this.actions,
        survivability ?? this.survivability);
  }

  factory PlayableCharacter.fromJson(Map<String, dynamic> json) =>
      _$PlayableCharacterFromJson(json);

  Map<String, dynamic> toJson() => _$PlayableCharacterToJson(this);
}
