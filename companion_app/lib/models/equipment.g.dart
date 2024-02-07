// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Equipment _$EquipmentFromJson(Map<String, dynamic> json) => Equipment(
      json['itemId'] as String,
      json['containerId'] as String,
      json['slotId'] as String,
    );

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'containerId': instance.containerId,
      'slotId': instance.slotId,
    };
