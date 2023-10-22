// To parse this JSON data, do
//
//     final bookingReponseEntity = bookingReponseEntityFromJson(jsonString);

import 'dart:convert';

BookingReponseEntity bookingReponseEntityFromJson(String str) => BookingReponseEntity.fromJson(json.decode(str));

String bookingReponseEntityToJson(BookingReponseEntity data) => json.encode(data.toJson());

class BookingReponseEntity {
    final String? message;
    final String? bookingId;
    final String? bayId;
    final String? floor;

    BookingReponseEntity({
        this.message,
        this.bookingId,
        this.bayId,
        this.floor,
    });

    BookingReponseEntity copyWith({
        String? message,
        String? bookingId,
        String? bayId,
        String? floor,
    }) => 
        BookingReponseEntity(
            message: message ?? this.message,
            bookingId: bookingId ?? this.bookingId,
            bayId: bayId ?? this.bayId,
            floor: floor ?? this.floor,
        );

    factory BookingReponseEntity.fromJson(Map<String, dynamic> json) => BookingReponseEntity(
        message: json["message"],
        bookingId: json["bookingId"],
        bayId: json["bay_id"],
        floor: json["floor"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "bookingId": bookingId,
        "bay_id": bayId,
        "floor": floor,
    };
}
