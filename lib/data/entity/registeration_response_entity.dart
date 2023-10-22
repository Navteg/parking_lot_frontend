// To parse this JSON data, do
//
//     final registeraionReponseEntity = registeraionReponseEntityFromJson(jsonString);

import 'dart:convert';

RegisteraionReponseEntity registeraionReponseEntityFromJson(String str) => RegisteraionReponseEntity.fromJson(json.decode(str));

String registeraionReponseEntityToJson(RegisteraionReponseEntity data) => json.encode(data.toJson());

class RegisteraionReponseEntity {
    final String? id;

    RegisteraionReponseEntity({
        this.id,
    });

    RegisteraionReponseEntity copyWith({
        String? id,
    }) => 
        RegisteraionReponseEntity(
            id: id ?? this.id,
        );

    factory RegisteraionReponseEntity.fromJson(Map<String, dynamic> json) => RegisteraionReponseEntity(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
