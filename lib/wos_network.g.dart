// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wos_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return ApiResponse(
    success: json['success'] as bool,
    response: json['response'],
  );
}

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'response': instance.response,
    };
