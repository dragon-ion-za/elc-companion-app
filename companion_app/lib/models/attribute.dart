import 'package:json_annotation/json_annotation.dart';
part 'attribute.g.dart';

@JsonSerializable()
class Attribute {
  final String type;
  final String? slot;
  final String? effectId;
  final num? value;

  Attribute(this.type, this.slot, this.effectId, this.value);

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}
