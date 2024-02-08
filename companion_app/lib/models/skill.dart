import 'package:json_annotation/json_annotation.dart';
part 'skill.g.dart';

@JsonSerializable()
class Skill {
  final String id;
  final num progression;
  final List<String> abilityIds;

  Skill(this.id, this.progression, this.abilityIds);

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  Map<String, dynamic> toJson() => _$SkillToJson(this);
}
