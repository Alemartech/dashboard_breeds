import 'package:dashboard_breeds/errors/repository_error.dart';
import 'package:dashboard_breeds/models/dog_image_model.dart';
import 'package:dashboard_breeds/models/dog_images_model.dart';
import 'package:dashboard_breeds/repositories/breeds_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'dogs_images_event.dart';
part 'dogs_images_state.dart';

class DogsImagesBloc extends Bloc<DogsImagesEvent, DogsImagesState> {
  final BreedsRepository breedsRepository;

  DogsImagesBloc({required this.breedsRepository})
      : super(DogsImagesNoState()) {
    on<DogsBreedRandomImageEvent>(_getDogBreedRandomImage);
    on<DogsBreedListImagesEvent>(_getDogBreedListImages);
    on<DogsSubBreedRandomImageEvent>(_getDogSubBreedRandomImage);
    on<DogsSubBreedListImagesEvent>(_getDogSubBreedListImages);
  }

  Future<void> _getDogBreedRandomImage(
      DogsBreedRandomImageEvent event, Emitter emit) async {
    emit(DogsImagesLoadingState());

    try {
      final dogImage = await breedsRepository.randomBreedImage(event.breed);
      emit(DogsRandomImageState(dogImage: dogImage));
    } on RepositoryError catch (e) {
      emit(DogErrorImagesState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(const DogErrorImagesState());
    }
  }

  Future<void> _getDogSubBreedRandomImage(
      DogsSubBreedRandomImageEvent event, Emitter emit) async {
    emit(DogsImagesLoadingState());

    try {
      final dogImage = await breedsRepository.randomSubBreedImage(
          event.breed, event.subBreed);
      emit(DogsRandomImageState(dogImage: dogImage));
    } on RepositoryError catch (e) {
      emit(DogErrorImagesState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(const DogErrorImagesState());
    }
  }

  Future<void> _getDogBreedListImages(
      DogsBreedListImagesEvent event, Emitter emit) async {
    emit(DogsImagesLoadingState());

    try {
      final dogImages = await breedsRepository.breedImagesList(event.breed);
      emit(DogListImagesState(dogImages: dogImages));
    } on RepositoryError catch (e) {
      emit(DogErrorImagesState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(const DogErrorImagesState());
    }
  }

  Future<void> _getDogSubBreedListImages(
      DogsSubBreedListImagesEvent event, Emitter emit) async {
    emit(DogsImagesLoadingState());

    try {
      final dogImages = await breedsRepository.subBreedImagesList(
          event.breed, event.subBreed);
      emit(DogListImagesState(dogImages: dogImages));
    } on RepositoryError catch (e) {
      emit(DogErrorImagesState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(const DogErrorImagesState());
    }
  }

  void getDogBreedRandomImage(String breed) =>
      add(DogsBreedRandomImageEvent(breed: breed));

  void getDogBreedListImages(String breed) =>
      add(DogsBreedListImagesEvent(breed: breed));

  void getDogSubBreedRandomImage(String breed, String subBreed) =>
      add(DogsSubBreedRandomImageEvent(breed: breed, subBreed: subBreed));

  void getDogSubBreedListImages(String breed, String subBreed) =>
      add(DogsSubBreedListImagesEvent(breed: breed, subBreed: subBreed));
}
