import 'dart:async';

import 'package:parking_lot_system/data/entity/login_response_entity.dart';

abstract class LoginRepository {
  FutureOr<LoginResponseEntity?> loginRequest({
    required String parkingId,
    required String password,
  });
}