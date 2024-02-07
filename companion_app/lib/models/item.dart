import 'package:elc_companion_app/models/attribute.dart';
import 'package:elc_companion_app/models/container.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@JsonSerializable()
class Item {
  final String id;
  final String name;
  final String? description;
  final num cost;
  final List<Attribute> attributes;
  final List<Container> containers;

  Item(this.id, this.name, this.description, this.cost, this.attributes, this.containers);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
