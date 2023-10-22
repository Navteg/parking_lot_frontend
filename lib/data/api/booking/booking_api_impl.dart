import 'package:dio/dio.dart';
import 'package:parking_lot_system/const/constants.dart';
import 'package:parking_lot_system/const/endpoint.dart';
import 'package:parking_lot_system/const/storage_keys.dart';
import 'package:parking_lot_system/data/api/booking/booking_api.dart';
import 'package:parking_lot_system/data/entity/booking_response_entity.dart';
import 'package:parking_lot_system/data/storage/key_value_storage_impl.dart';
import 'package:parking_lot_system/network/api_clinet.dart';

class BookingApiImpl extends BookingApi {
  @override
  Future<BookingReponseEntity> getBookings({
    required vehicleNumber,
    required vehicleType,
  }) async {
    try {
      final client = ApiClient(Dio(), Endpoint.baseUrl);
      final token = await KeyValueStorageImpl().read(
        StorageKeys.token,
      );

      final response = await client.post(
        Endpoint.bookSlot,
        data: {
          "vehicleNumber": vehicleNumber,
          "vehicleType": Constants.vehicleTypeMap[vehicleType],
        },
        options: Options()
          ..headers = <String, dynamic>{
            'Authorization': 'Bearer $token',
          },
      );
      return BookingReponseEntity.fromJson(response);
    } catch (e) {
      return BookingReponseEntity(
        message: e.toString(),
      );
    }
  }
}
