import 'package:equatable/equatable.dart';

class DogImagesModel extends Equatable {
  final List<String> message;
  final String status;

  const DogImagesModel({required this.message, required this.status});

  factory DogImagesModel.fromJson(Map<String, dynamic> data) {
    return DogImagesModel(
        message: List.from(data["message"]), status: data["status"]);
  }

  @override
  List<Object?> get props => [message, status];
}
