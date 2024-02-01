import 'package:json_annotation/json_annotation.dart';
part 'lookup.g.dart';

@JsonSerializable()
class Lookup {
  final String id;
  final String name;

  Lookup(this.id, this.name);

  factory Lookup.fromJson(Map<String, dynamic> json) => _$LookupFromJson(json);

  Map<String, dynamic> toJson() => _$LookupToJson(this);
}
