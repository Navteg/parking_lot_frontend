import 'package:parking_lot_system/data/api/registeration/registeration_api_impl.dart';
import 'package:parking_lot_system/data/entity/registeration_response_entity.dart';
import 'package:parking_lot_system/domain/repository/register/register_repository.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  @override
  Future<RegisteraionReponseEntity> register({
    required String floor,
    required String smallSlot,
    required String mediumSlot,
    required String largeSlot,
    required String xLargeSlot,
    required String password,
  }) {
    return RegisterationApiImpl().register(
      floor: floor,
      smallSlot: smallSlot,
      mediumSlot: mediumSlot,
      largeSlot: largeSlot,
      xLargeSlot: xLargeSlot,
      password: password,
    );
  }
}
