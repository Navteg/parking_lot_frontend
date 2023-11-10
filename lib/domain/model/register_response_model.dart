import 'package:equatable/equatable.dart';

class RegistrationResponseModel extends Equatable {
  final String id; // parking id

  const RegistrationResponseModel({
    required this.id,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
