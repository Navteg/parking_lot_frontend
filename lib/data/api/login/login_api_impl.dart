import "package:dio/dio.dart";
import 'package:parking_lot_system/const/endpoint.dart';
import 'package:parking_lot_system/data/api/login/login_api.dart';
import 'package:parking_lot_system/data/entity/login_response_entity.dart';
import 'package:parking_lot_system/network/api_clinet.dart';

class LoginApiImpl extends LoginApi {
  @override
  Future<LoginResponseEntity> login({
    required String parkingId,
    required String password,
  }) async {
    try {
      final client = ApiClient(Dio(), Endpoint.baseUrl);
      final response = await client.post(
        Endpoint.login,
        data: {
          'id': parkingId.toUpperCase(),
          'password': password,
        },
      );
      return LoginResponseEntity.fromJson(response);
    } catch (e) {
      return LoginResponseEntity(
        message: e.toString(),
        token: "",
      );
    }
  }
}
