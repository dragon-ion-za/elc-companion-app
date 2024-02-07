import 'package:elc_companion_app/models/equipment.dart';
import 'package:json_annotation/json_annotation.dart';
part 'character.g.dart';

@JsonSerializable()
class Character {
  final String? id;
  final String name;
  final String bio;
  final String? raceId;
  final String? factionId;
  final String? eraId;

  final List<String> talentIds;
  final List<Equipment> equipment;
  final List<String> skillIds;

  Character.empty()
      : id = null,
        name = '',
        bio = '',
        raceId = null,
        factionId = null,
        eraId = null,
        talentIds = [],
        equipment = [],
        skillIds = [];

  Character(this.id, this.name, this.bio, this.raceId, this.factionId,
      this.eraId, this.talentIds, this.equipment, this.skillIds);

  bool get areStatsValid {
    return name.isNotEmpty && (raceId != null && raceId != '0') && (factionId != null && factionId != '0') && (eraId != null && eraId != '0');
  }

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
