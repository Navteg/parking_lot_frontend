// To parse this JSON data, do
//
//     final loginResponseEntity = loginResponseEntityFromJson(jsonString);

import 'dart:convert';

LoginResponseEntity loginResponseEntityFromJson(String str) => LoginResponseEntity.fromJson(json.decode(str));

String loginResponseEntityToJson(LoginResponseEntity data) => json.encode(data.toJson());

class LoginResponseEntity {
    String message;
    String token;

    LoginResponseEntity({
        required this.message,
        required this.token,
    });

    LoginResponseEntity copyWith({
        String? message,
        String? token,
    }) => 
        LoginResponseEntity(
            message: message ?? this.message,
            token: token ?? this.token,
        );

    factory LoginResponseEntity.fromJson(Map<String, dynamic> json) => LoginResponseEntity(
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
    };
}
