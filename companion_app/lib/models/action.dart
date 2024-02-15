import 'package:json_annotation/json_annotation.dart';

part 'action.g.dart';

@JsonSerializable()
class Action {
  final String name;
  final String blurb;
  final String description;
  final num cost;
  final num damage;
  final num accuracy;
  final num edgeHindrance;

  Action(this.name, this.blurb, this.description, this.cost, this.damage, this.accuracy, this.edgeHindrance);

  factory Action.fromJson(Map<String, dynamic> json) =>
      _$ActionFromJson(json);

  Map<String, dynamic> toJson() => _$ActionToJson(this);
}