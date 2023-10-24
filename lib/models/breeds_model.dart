import 'package:equatable/equatable.dart';

class BreedsModel extends Equatable {
  final List<String> message;
  final String status;

  const BreedsModel({required this.message, required this.status});

  factory BreedsModel.fromJson(Map<String, dynamic> data) {
    return BreedsModel(message: data["message"], status: data["status"]);
  }

  @override
  List<Object?> get props => [message, status];
}
