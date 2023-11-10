import 'dart:async';

import 'package:parking_lot_system/data/entity/booking_response_entity.dart';
import 'package:parking_lot_system/domain/model/booking_response_model.dart';
import 'package:parking_lot_system/domain/repository/booking/booking_repository_impl.dart';

class BookingUseCase {
  FutureOr<BookingResponseModel?> execute({
    required String vehicleNumber,
    required String vehicleType,
  }) async {
    final data = await BookingRepositoryImpl().getBookings(
      vehicleNumber: vehicleNumber,
      vehicleType: vehicleType,
    );
    return toBookingResponseModel(entities: data);
  }

  BookingResponseModel toBookingResponseModel(
      {required final BookingReponseEntity entities}) {
    return BookingResponseModel(
      bayId: entities.bayId ?? '',
      bookingId: entities.bookingId ?? '',
      floor: entities.floor ?? '',
      error: entities.message ?? '',
    );
  }
}
