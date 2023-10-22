import 'package:parking_lot_system/data/entity/booking_response_entity.dart';

abstract class BookingApi {
  Future<BookingReponseEntity> getBookings({
    required vehicleNumber,
    required vehicleType,
  });
}
