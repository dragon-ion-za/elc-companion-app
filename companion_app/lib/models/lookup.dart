import 'package:json_annotation/json_annotation.dart';
part 'lookup.g.dart';

@JsonSerializable()
class Lookup {
  final String name;

  Lookup(this.name);

  factory Lookup.fromJson(Map<String, dynamic> json) => _$LookupFromJson(json);

  Map<String, dynamic> toJson() => _$LookupToJson(this);
}
