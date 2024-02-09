// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
      json['id'] as String,
      json['name'] as String,
      json['skillId'] as String,
      json['isElite'] as bool,
    );

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'skillId': instance.skillId,
      'isElite': instance.isElite,
    };
