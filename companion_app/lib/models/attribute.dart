import 'package:json_annotation/json_annotation.dart';
part 'attribute.g.dart';

@JsonSerializable()
class Attribute {
  final int type;
  final String? targetId;
  final String? value;

  Attribute(this.type, this.targetId, this.value);

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}
