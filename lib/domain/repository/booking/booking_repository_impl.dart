import 'package:parking_lot_system/data/api/booking/booking_api_impl.dart';
import 'package:parking_lot_system/data/entity/booking_response_entity.dart';
import 'package:parking_lot_system/domain/repository/booking/booking_repository.dart';

class BookingRepositoryImpl extends BookingRepository {
  @override
  Future<BookingReponseEntity> getBookings({
    required vehicleNumber,
    required vehicleType,
  }) {
    return BookingApiImpl()
        .getBookings(vehicleNumber: vehicleNumber, vehicleType: vehicleType);
  }
}
