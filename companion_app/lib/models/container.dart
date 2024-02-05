import 'package:json_annotation/json_annotation.dart';
part 'container.g.dart';

@JsonSerializable()
class Container {
  final String id;
  final String slot;

  Container(this.id, this.slot);
  
  factory Container.fromJson(Map<String, dynamic> json) =>
      _$ContainerFromJson(json);

  Map<String, dynamic> toJson() => _$ContainerToJson(this);
}
