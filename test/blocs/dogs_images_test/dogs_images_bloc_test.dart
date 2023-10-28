import 'package:bloc_test/bloc_test.dart';
import 'package:dashboard_breeds/blocs/dogs_images/dogs_images_bloc.dart';
import 'package:dashboard_breeds/models/dog_image_model.dart';
import 'package:dashboard_breeds/models/dog_images_model.dart';
import 'package:dashboard_breeds/repositories/breeds_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dogs_images_bloc_test.mocks.dart';

@GenerateMocks([BreedsRepository])
void main() {
  late BreedsRepository breedsRepository;

  setUp(() => breedsRepository = MockBreedsRepository());

  group("test getDogBreedRandomImage", () {
    const breed = "mastiff";
    blocTest<DogsImagesBloc, DogsImagesState>(
      "get random breed image",
      setUp: () => when(breedsRepository.randomBreedImage(breed)).thenAnswer(
          (_) async =>
              const DogImageModel(message: "image_1.jpg", status: "success")),
      build: () => DogsImagesBloc(breedsRepository: breedsRepository),
      act: (bloc) => bloc.getDogBreedRandomImage(breed),
      expect: () => [
        DogsImagesLoadingState(),
        const DogsRandomImageState(
            dogImage: DogImageModel(message: "image_1.jpg", status: "success")),
      ],
    );

    blocTest<DogsImagesBloc, DogsImagesState>(
      "throwing an error while getting random breed image",
      setUp: () =>
          when(breedsRepository.randomBreedImage(breed)).thenThrow(Error()),
      build: () => DogsImagesBloc(breedsRepository: breedsRepository),
      act: (bloc) => bloc.getDogBreedRandomImage(breed),
      expect: () => [
        DogsImagesLoadingState(),
        isA<DogErrorImagesState>(),
      ],
    );
  });

  group("test getDogSubBreedRandomImage ", () {
    const breed = "hound";
    const subBreed = "afghan";
    blocTest<DogsImagesBloc, DogsImagesState>(
      "get random sub-breed image",
      setUp: () => when(breedsRepository.randomSubBreedImage(breed, subBreed))
          .thenAnswer((_) async =>
              const DogImageModel(message: "image_1.jpg", status: "success")),
      build: () => DogsImagesBloc(breedsRepository: breedsRepository),
      act: (bloc) => bloc.getDogSubBreedRandomImage(breed, subBreed),
      expect: () => [
        DogsImagesLoadingState(),
        const DogsRandomImageState(
            dogImage: DogImageModel(message: "image_1.jpg", status: "success")),
      ],
    );

    blocTest<DogsImagesBloc, DogsImagesState>(
      "throwing an error while getting random sub-breed image",
      setUp: () => when(breedsRepository.randomSubBreedImage(breed, subBreed))
          .thenThrow(Error()),
      build: () => DogsImagesBloc(breedsRepository: breedsRepository),
      act: (bloc) => bloc.getDogSubBreedRandomImage(breed, subBreed),
      expect: () => [
        DogsImagesLoadingState(),
        isA<DogErrorImagesState>(),
      ],
    );
  });

  group("test getDogBreedListImages", () {
    const breed = "mastiff";

    blocTest<DogsImagesBloc, DogsImagesState>(
      "get breed list images ",
      setUp: () => when(breedsRepository.breedImagesList(breed)).thenAnswer(
          (_) async => const DogImagesModel(message: [
                "image_1.jpg",
                "image_2.jpg",
                "image_3.jpg",
                "image_4.jpg"
              ], status: "success")),
      build: () => DogsImagesBloc(breedsRepository: breedsRepository),
      act: (bloc) => bloc.getDogBreedListImages(breed),
      expect: () => [
        DogsImagesLoadingState(),
        const DogListImagesState(
          dogImages: DogImagesModel(message: [
            "image_1.jpg",
            "image_2.jpg",
            "image_3.jpg",
            "image_4.jpg"
          ], status: "success"),
        ),
      ],
    );

    blocTest<DogsImagesBloc, DogsImagesState>(
      "throwing an error while getting breed list images",
      setUp: () =>
          when(breedsRepository.breedImagesList(breed)).thenThrow(Error()),
      build: () => DogsImagesBloc(breedsRepository: breedsRepository),
      act: (bloc) => bloc.getDogBreedListImages(breed),
      expect: () => [
        DogsImagesLoadingState(),
        isA<DogErrorImagesState>(),
      ],
    );
  });

  group("test getDogSubBreedListImages", () {
    const breed = "hound";
    const subBreed = "afghan";

    blocTest<DogsImagesBloc, DogsImagesState>(
      "get sub-breed list images ",
      setUp: () => when(breedsRepository.subBreedImagesList(breed, subBreed))
          .thenAnswer((_) async => const DogImagesModel(message: [
                "image_1.jpg",
                "image_2.jpg",
                "image_3.jpg",
                "image_4.jpg"
              ], status: "success")),
      build: () => DogsImagesBloc(breedsRepository: breedsRepository),
      act: (bloc) => bloc.getDogSubBreedListImages(breed, subBreed),
      expect: () => [
        DogsImagesLoadingState(),
        const DogListImagesState(
          dogImages: DogImagesModel(message: [
            "image_1.jpg",
            "image_2.jpg",
            "image_3.jpg",
            "image_4.jpg"
          ], status: "success"),
        ),
      ],
    );

    blocTest<DogsImagesBloc, DogsImagesState>(
      "throwing an error while getting sub-breed list images",
      setUp: () => when(breedsRepository.subBreedImagesList(breed, subBreed))
          .thenThrow(Error()),
      build: () => DogsImagesBloc(breedsRepository: breedsRepository),
      act: (bloc) => bloc.getDogSubBreedListImages(breed, subBreed),
      expect: () => [
        DogsImagesLoadingState(),
        isA<DogErrorImagesState>(),
      ],
    );
  });
}
