// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
// ignore: file_names
import 'package:parking_lot_system/const/endpoint.dart';
import 'package:parking_lot_system/const/storage_keys.dart';
import 'package:parking_lot_system/data/api/slot-release/slot-release_api.dart';
import 'package:parking_lot_system/data/entity/slot_release_response_entity.dart';
import 'package:parking_lot_system/data/storage/key_value_storage_impl.dart';
import 'package:parking_lot_system/network/api_clinet.dart';

class SlotReleaseApiImpl extends SlotReleaseApi {
  @override
  Future<SlotReleaseReponseEntity> getSlotRelease({
    required String vehicleNumber,
  }) async {
    final client = ApiClient(Dio(), Endpoint.baseUrl);
    final token = await KeyValueStorageImpl().read(
      StorageKeys.token,
    );
    try {
      final response = await client.post(
        Endpoint.releaseSlot,
        data: {
          'vehicleNumber': vehicleNumber,
        },
        options: Options()
          ..headers = <String, dynamic>{
            'Authorization': 'Bearer $token',
          },
      );
      return SlotReleaseReponseEntity.fromJson(response);
    } catch (e) {
      return SlotReleaseReponseEntity(
        message: e.toString(),
      );
    }
  }
}
