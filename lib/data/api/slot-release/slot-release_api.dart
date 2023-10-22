import 'package:parking_lot_system/data/entity/slot_release_response_entity.dart';

abstract class SlotReleaseApi {
  Future<SlotReleaseReponseEntity> getSlotRelease({
    required String vehicleNumber,
  });
}
