// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cn_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke _$JokeFromJson(Map<String, dynamic> json) => Joke(
      icon_url: json['icon_url'] as String,
      id: json['id'] as String,
      url: json['url'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$JokeToJson(Joke instance) => <String, dynamic>{
      'icon_url': instance.icon_url,
      'id': instance.id,
      'url': instance.url,
      'value': instance.value,
    };
