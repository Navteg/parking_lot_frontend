import 'package:parking_lot_system/data/api/slot-release/slot-release-api-impl.dart';
import 'package:parking_lot_system/data/entity/slot_release_response_entity.dart';
import 'package:parking_lot_system/domain/repository/release/release_repository.dart';

class ReleaseRepositoryImpl implements ReleaseRepository {
  @override
  Future<SlotReleaseReponseEntity> releaseBooking({required vehicleNumber}) {
    return SlotReleaseApiImpl().getSlotRelease(vehicleNumber: vehicleNumber);
  }
}
