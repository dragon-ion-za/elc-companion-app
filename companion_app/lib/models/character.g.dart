// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      json['id'] as String?,
      json['name'] as String,
      json['bio'] as String,
      json['raceId'] as String?,
      json['factionId'] as String?,
      json['eraId'] as String?,
      (json['talentIds'] as List<dynamic>).map((e) => e as String).toList(),
      (json['equipment'] as List<dynamic>)
          .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['skills'] as List<dynamic>)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['survivability'] == null
          ? null
          : Survivability.fromJson(
              json['survivability'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bio': instance.bio,
      'raceId': instance.raceId,
      'factionId': instance.factionId,
      'eraId': instance.eraId,
      'talentIds': instance.talentIds,
      'equipment': instance.equipment,
      'skills': instance.skills,
      'survivability': instance.survivability,
    };
