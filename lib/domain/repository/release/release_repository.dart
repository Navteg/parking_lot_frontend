import 'package:parking_lot_system/data/entity/slot_release_response_entity.dart';

abstract class ReleaseRepository {
  Future<SlotReleaseReponseEntity> releaseBooking({
    required vehicleNumber,
  });
}