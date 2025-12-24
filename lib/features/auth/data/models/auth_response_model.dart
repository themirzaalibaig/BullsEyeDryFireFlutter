import 'user_model.dart';

class TokenModel {
  final String accessToken;
  final String refreshToken;

  TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'accessToken': accessToken, 'refreshToken': refreshToken};
  }
}

class AuthResponseModel {
  final bool success;
  final String message;
  final UserModel? user;
  final TokenModel? token;
  final List<ErrorModel>? errors;

  AuthResponseModel({
    required this.success,
    required this.message,
    this.user,
    this.token,
    this.errors,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      user: json['data']?['user'] != null
          ? UserModel.fromJson(json['data']['user'] as Map<String, dynamic>)
          : null,
      token: json['data']?['token'] != null
          ? TokenModel.fromJson(json['data']['token'] as Map<String, dynamic>)
          : null,
      errors: json['errors'] != null
          ? (json['errors'] as List)
                .map((e) => ErrorModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }
}

class ErrorModel {
  final String? field;
  final String message;
  final String? code;
  final dynamic value;

  ErrorModel({this.field, required this.message, this.code, this.value});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      field: json['field'] as String?,
      message: json['message'] as String? ?? '',
      code: json['code'] as String?,
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'field': field, 'message': message, 'code': code, 'value': value};
  }
}
