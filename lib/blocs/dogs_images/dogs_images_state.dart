part of 'dogs_images_bloc.dart';

abstract class DogsImagesState extends Equatable {
  const DogsImagesState();

  @override
  List<Object?> get props => [];
}

class DogsImagesNoState extends DogsImagesState {}

class DogsImagesLoadingState extends DogsImagesState {}

class DogsRandomImageState extends DogsImagesState {
  final DogImageModel dogImage;

  const DogsRandomImageState({required this.dogImage});

  @override
  List<Object> get props => [dogImage];
}

class DogListImagesState extends DogsImagesState {
  final DogImagesModel dogImages;

  const DogListImagesState({required this.dogImages});

  @override
  List<Object> get props => [dogImages];
}

class DogErrorImagesState extends DogsImagesState {
  final String? errorMessage;

  const DogErrorImagesState({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
