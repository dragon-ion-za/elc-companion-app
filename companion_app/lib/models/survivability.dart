import 'package:json_annotation/json_annotation.dart';
part 'survivability.g.dart';

@JsonSerializable()
class Survivability {
  final num maxHp;
  final num currentHp;
  final num currentStress;
  final num mitigationScore;

  Survivability(this.maxHp, this.currentHp, this.currentStress, this.mitigationScore);

  factory Survivability.fromJson(Map<String, dynamic> json) => _$SurvivabilityFromJson(json);

  Map<String, dynamic> toJson() => _$SurvivabilityToJson(this);
}
