import 'dart:async';

import 'package:parking_lot_system/data/api/login/login_api_impl.dart';
import 'package:parking_lot_system/data/entity/login_response_entity.dart';
import 'package:parking_lot_system/domain/repository/login/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  @override
  FutureOr<LoginResponseEntity?> loginRequest({
    required String parkingId,
    required String password,
  }) {
    return LoginApiImpl().login(parkingId: parkingId, password: password);
  }
}
