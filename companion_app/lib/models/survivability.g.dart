// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survivability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Survivability _$SurvivabilityFromJson(Map<String, dynamic> json) =>
    Survivability(
      json['maxHp'] as num,
      json['currentHp'] as num,
      json['currentStress'] as num,
      json['mitigationScore'] as num,
    );

Map<String, dynamic> _$SurvivabilityToJson(Survivability instance) =>
    <String, dynamic>{
      'maxHp': instance.maxHp,
      'currentHp': instance.currentHp,
      'currentStress': instance.currentStress,
      'mitigationScore': instance.mitigationScore,
    };
