// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attribute _$AttributeFromJson(Map<String, dynamic> json) => Attribute(
      json['type'] as String,
      json['slot'] as String?,
      json['effectId'] as String?,
      json['value'] as num?,
    );

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
      'type': instance.type,
      'slot': instance.slot,
      'effectId': instance.effectId,
      'value': instance.value,
    };
