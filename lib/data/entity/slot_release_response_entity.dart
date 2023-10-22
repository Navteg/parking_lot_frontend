// To parse this JSON data, do
//
//     final slotReleaseReponseEntity = slotReleaseReponseEntityFromJson(jsonString);

import 'dart:convert';

SlotReleaseReponseEntity slotReleaseReponseEntityFromJson(String str) =>
    SlotReleaseReponseEntity.fromJson(json.decode(str));

String slotReleaseReponseEntityToJson(SlotReleaseReponseEntity data) =>
    json.encode(data.toJson());

class SlotReleaseReponseEntity {
  final String? message;
  final int? totalAmount;
  final int? totalHrs;
  final String? entryTime;
  final String? exitTime;

  SlotReleaseReponseEntity({
    this.message,
    this.totalAmount,
    this.totalHrs,
    this.entryTime,
    this.exitTime,
  });

  factory SlotReleaseReponseEntity.fromJson(Map<String, dynamic> json) =>
      SlotReleaseReponseEntity(
        message: json["message"],
        totalAmount: json["totalAmount"],
        totalHrs: json["totalHrs"],
        entryTime: json["entryTime"],
        exitTime: json["exitTime"],
      );

  SlotReleaseReponseEntity copyWith({
    String? message,
    int? totalAmount,
    int? totalHrs,
    String? entryTime,
    String? exitTime,
  }) =>
      SlotReleaseReponseEntity(
        message: message ?? this.message,
        totalAmount: totalAmount ?? this.totalAmount,
        totalHrs: totalHrs ?? this.totalHrs,
        entryTime: entryTime ?? this.entryTime,
        exitTime: exitTime ?? this.exitTime,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "totalAmount": totalAmount,
        "totalHrs": totalHrs,
        "entryTime": entryTime,
        "exitTime": exitTime,
      };
}
