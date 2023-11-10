import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final String token;
  final String error;

  const LoginResponseModel({
    required this.token,
    required this.error,
  });

  @override
  List<Object> get props => [token, error];
}
