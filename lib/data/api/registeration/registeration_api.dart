import 'package:parking_lot_system/data/entity/registeration_response_entity.dart';

abstract class RegisterationApi {
  Future<RegisteraionReponseEntity> register({
    required String floor,
    required String smallSlot,
    required String mediumSlot,
    required String largeSlot,
    required String xLargeSlot,
    required String password,
  });
}
