import 'package:parking_lot_system/data/entity/booking_response_entity.dart';

abstract class BookingRepository {
  Future<BookingReponseEntity> getBookings({
    required vehicleNumber,
    required vehicleType,
  });
}