part of 'dogs_images_bloc.dart';

abstract class DogsImagesEvent extends Equatable {
  const DogsImagesEvent();

  @override
  List<Object> get props => [];
}

class DogsBreedRandomImageEvent extends DogsImagesEvent {
  final String breed;

  const DogsBreedRandomImageEvent({required this.breed});

  @override
  List<Object> get props => [breed];
}

class DogsBreedListImagesEvent extends DogsImagesEvent {
  final String breed;

  const DogsBreedListImagesEvent({required this.breed});

  @override
  List<Object> get props => [breed];
}

class DogsSubBreedRandomImageEvent extends DogsImagesEvent {
  final String breed;
  final String subBreed;

  const DogsSubBreedRandomImageEvent(
      {required this.breed, required this.subBreed});

  @override
  List<Object> get props => [breed, subBreed];
}

class DogsSubBreedListImagesEvent extends DogsImagesEvent {
  final String breed;
  final String subBreed;

  const DogsSubBreedListImagesEvent(
      {required this.breed, required this.subBreed});

  @override
  List<Object> get props => [breed, subBreed];
}
