// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skill _$SkillFromJson(Map<String, dynamic> json) => Skill(
      json['id'] as String,
      json['progression'] as num,
      (json['abilityIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'id': instance.id,
      'abilityIds': instance.abilityIds,
      'progression': instance.progression,
    };
