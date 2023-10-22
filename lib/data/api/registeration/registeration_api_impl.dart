import 'package:dio/dio.dart';
import 'package:parking_lot_system/const/endpoint.dart';
import 'package:parking_lot_system/data/api/registeration/registeration_api.dart';
import 'package:parking_lot_system/data/entity/registeration_response_entity.dart';
import 'package:parking_lot_system/network/api_clinet.dart';

class RegisterationApiImpl extends RegisterationApi {
  @override
  Future<RegisteraionReponseEntity> register({
    required String floor,
    required String smallSlot,
    required String mediumSlot,
    required String largeSlot,
    required String xLargeSlot,
    required String password,
  }) async {
    try {
      final client = ApiClient(Dio(), Endpoint.baseUrl);
      final response = await client.post(
        Endpoint.register,
        data: {
          "password": password,
          "floors": floor,
          "smallSlots": smallSlot,
          "mediumSlots": mediumSlot,
          "largeSlots": largeSlot,
          "xLargeSlots": xLargeSlot,
        },
      );
      return RegisteraionReponseEntity.fromJson(response);
    } catch (e) {
      return RegisteraionReponseEntity(
        id: '',
      );
    }
  }
}
