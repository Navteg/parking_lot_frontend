import 'dart:async';

import 'package:parking_lot_system/data/entity/slot_release_response_entity.dart';
import 'package:parking_lot_system/domain/model/release_response_model.dart';
import 'package:parking_lot_system/domain/repository/release/release_repository_impl.dart';

class ReleaseUseCase {
  FutureOr<ReleaseResponseModel?> execute({
    required String vehicleNumber,
  }) async {
    final data = await ReleaseRepositoryImpl().releaseBooking(
      vehicleNumber: vehicleNumber,
    );
    return toReleaseResponseModel(entities: data);
  }

  ReleaseResponseModel toReleaseResponseModel(
      {required final SlotReleaseReponseEntity entities}) {
    return ReleaseResponseModel(
      entryTime: entities.entryTime ?? '',
      exitTime: entities.exitTime ?? '',
      totalAmount: entities.totalAmount ?? 0,
      totalHrs: entities.totalHrs ?? 0,
      error: entities.message ?? '',
    );
  }
}
