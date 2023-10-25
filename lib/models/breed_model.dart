import 'package:equatable/equatable.dart';

class BreedModel extends Equatable {
  final String breed;
  final List<String> subBreeds;

  const BreedModel({required this.breed, required this.subBreeds});

  factory BreedModel.fromMap(String key, dynamic value) {
    return BreedModel(breed: key, subBreeds: List.from(value));
  }

  @override
  List<Object?> get props => [breed, subBreeds];
}
