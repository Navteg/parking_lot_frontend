import 'dart:async';

import 'package:parking_lot_system/data/entity/login_response_entity.dart';
import 'package:parking_lot_system/domain/model/login_response_model.dart';
import 'package:parking_lot_system/domain/repository/login/login_repository_impl.dart';

class LoginUseCase {
  FutureOr<LoginResponseModel?> execute({
    required String parkingId,
    required String password,
  }) async {
    final data = await LoginRepositoryImpl().loginRequest(
      parkingId: parkingId,
      password: password,
    );
    return toLoginResponseModel(entities: data!);
  }

  LoginResponseModel toLoginResponseModel(
      {required final LoginResponseEntity entities}) {
    return LoginResponseModel(
      token: entities.token,
      error: entities.message,
    );
  }
}
