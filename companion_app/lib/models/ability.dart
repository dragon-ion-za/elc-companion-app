import 'package:json_annotation/json_annotation.dart';

part 'ability.g.dart';

@JsonSerializable()
class Ability {
  final String id;
  final String name;
  final String skillId;
  final bool isElite;

  Ability(this.id, this.name, this.skillId, this.isElite);

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}