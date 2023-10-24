import 'package:equatable/equatable.dart';

class BreedModel extends Equatable {
  final String message;
  final String status;

  const BreedModel({required this.message, required this.status});

  factory BreedModel.fromJson(Map<String, dynamic> data) {
    return BreedModel(message: data["message"], status: data["status"]);
  }

  @override
  List<Object?> get props => [message, status];
}
