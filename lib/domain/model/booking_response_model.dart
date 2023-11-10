import 'package:equatable/equatable.dart';

class BookingResponseModel extends Equatable {
  final String bookingId;
  final String bayId;
  final String floor;
  final String? error;

  const BookingResponseModel({
    required this.bookingId,
    required this.bayId,
    required this.floor,
    this.error,
  });

  @override
  List<Object?> get props => [
        bookingId,
        bayId,
        floor,
        error,
      ];
}
