import 'package:equatable/equatable.dart';

class ReleaseResponseModel extends Equatable {
  final int totalAmount;
  final int totalHrs;
  final String entryTime;
  final String exitTime;
  final String? error;

  const ReleaseResponseModel({
    required this.totalAmount,
    required this.totalHrs,
    required this.entryTime,
    required this.exitTime,
    this.error,
  });

  @override
  List<Object?> get props => [
        totalAmount,
        totalHrs,
        entryTime,
        exitTime,
        error,
      ];
}
