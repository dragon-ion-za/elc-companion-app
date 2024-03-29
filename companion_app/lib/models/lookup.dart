import 'package:json_annotation/json_annotation.dart';
part 'lookup.g.dart';

@JsonSerializable()
class Lookup {
  final String id;
  final String name;
  final String? blurb;
  final num score;

  Lookup(this.id, this.name, this.blurb, this.score);

  factory Lookup.fromJson(Map<String, dynamic> json) => _$LookupFromJson(json);

  Map<String, dynamic> toJson() => _$LookupToJson(this);
}
