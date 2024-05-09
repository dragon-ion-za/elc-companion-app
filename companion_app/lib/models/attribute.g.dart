// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attribute _$AttributeFromJson(Map<String, dynamic> json) => Attribute(
      (json['type'] as num).toInt(),
      json['targetId'] as String?,
      json['value'] as String?,
    );

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
      'type': instance.type,
      'targetId': instance.targetId,
      'value': instance.value,
    };
