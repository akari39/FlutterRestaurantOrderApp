// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wos_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return ApiResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    notLogin: json['notLogin'] as bool,
    data: json['data'],
  );
}

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'notLogin': instance.notLogin,
      'data': instance.data,
    };
