// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Action _$ActionFromJson(Map<String, dynamic> json) => Action(
      json['name'] as String,
      json['blurb'] as String,
      json['description'] as String,
      json['cost'] as num,
      json['damage'] as num,
      json['accuracy'] as num,
      json['edgeHindrance'] as num,
    );

Map<String, dynamic> _$ActionToJson(Action instance) => <String, dynamic>{
      'name': instance.name,
      'blurb': instance.blurb,
      'description': instance.description,
      'cost': instance.cost,
      'damage': instance.damage,
      'accuracy': instance.accuracy,
      'edgeHindrance': instance.edgeHindrance,
    };
