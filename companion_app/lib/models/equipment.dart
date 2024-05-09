import 'package:json_annotation/json_annotation.dart';
part 'equipment.g.dart';

@JsonSerializable()
class Equipment {
  final String id;
  final String itemId;
  final String containerId;
  final String slotId;

  Equipment(this.id, this.itemId, this.containerId, this.slotId);

  factory Equipment.fromJson(Map<String, dynamic> json) => _$EquipmentFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentToJson(this);
}
