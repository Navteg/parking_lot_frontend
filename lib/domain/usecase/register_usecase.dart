import 'dart:async';

import 'package:parking_lot_system/data/entity/registeration_response_entity.dart';
import 'package:parking_lot_system/domain/model/register_response_model.dart';
import 'package:parking_lot_system/domain/repository/register/register_repository_impl.dart';

class RegisterUseCase {
  FutureOr<RegistrationResponseModel?> execute({
    required String floor,
    required String smallSlot,
    required String mediumSlot,
    required String largeSlot,
    required String xLargeSlot,
    required String password,
  }) async {
    final data = await RegisterRepositoryImpl().register(
      floor: floor,
      smallSlot: smallSlot,
      mediumSlot: mediumSlot,
      largeSlot: largeSlot,
      xLargeSlot: xLargeSlot,
      password: password,
    );
    return toRegisterResponseModel(entities: data);
  }

  RegistrationResponseModel toRegisterResponseModel(
      {required final RegisteraionReponseEntity entities}) {
    return RegistrationResponseModel(
      id: entities.id ?? '',
    );
  }
}
