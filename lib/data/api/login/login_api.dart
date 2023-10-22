import 'package:parking_lot_system/data/entity/login_response_entity.dart';

abstract class LoginApi {
  Future<LoginResponseEntity> login({
    required String parkingId,
    required String password,
  });
}