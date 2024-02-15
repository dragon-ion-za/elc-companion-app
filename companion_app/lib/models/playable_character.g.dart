// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playable_character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayableCharacter _$PlayableCharacterFromJson(Map<String, dynamic> json) =>
    PlayableCharacter(
      json['id'] as String?,
      json['name'] as String,
      json['bio'] as String,
      json['raceId'] as String?,
      json['factionId'] as String?,
      json['eraId'] as String?,
      json['accuracy'] as num,
      (json['talentIds'] as List<dynamic>).map((e) => e as String).toList(),
      (json['equipment'] as List<dynamic>)
          .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['skills'] as List<dynamic>)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['actions'] as List<dynamic>)
          .map((e) => Action.fromJson(e as Map<String, dynamic>))
          .toList(),
      Survivability.fromJson(json['survivability'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayableCharacterToJson(PlayableCharacter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bio': instance.bio,
      'raceId': instance.raceId,
      'factionId': instance.factionId,
      'eraId': instance.eraId,
      'accuracy': instance.accuracy,
      'talentIds': instance.talentIds,
      'equipment': instance.equipment,
      'skills': instance.skills,
      'actions': instance.actions,
      'survivability': instance.survivability,
    };
