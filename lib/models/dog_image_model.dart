import 'package:equatable/equatable.dart';

class DogImageModel extends Equatable {
  final String message;
  final String status;

  const DogImageModel({required this.message, required this.status});

  factory DogImageModel.fromJson(Map<String, dynamic> data) {
    return DogImageModel(message: data["message"], status: data["status"]);
  }

  @override
  List<Object?> get props => [message, status];
}
