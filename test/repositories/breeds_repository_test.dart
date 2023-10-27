import 'package:dashboard_breeds/errors/repository_error.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:dashboard_breeds/models/dog_image_model.dart';
import 'package:dashboard_breeds/models/dog_images_model.dart';
import 'package:dashboard_breeds/repositories/breeds_repository.dart';
import 'package:dashboard_breeds/services/breeds_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'breeds_repository_test.mocks.dart';

@GenerateMocks([BreedsApiService])
void main() {
  late BreedsRepository breedsRepository;
  late BreedsApiService service;

  setUp(() {
    service = MockBreedsApiService();
    breedsRepository = BreedsRepository(service: service);
  });

  group("testing method breedsList", () {
    test("get list breeds and sub-breeds for dropdown button", () async {
      when(service.getBreedList()).thenAnswer((_) async => const [
            BreedModel(breed: "affenpinscher", subBreeds: []),
            BreedModel(breed: "australian", subBreeds: ["shepherd"]),
            BreedModel(breed: "bullterrier", subBreeds: ["staffordshire"]),
            BreedModel(
                breed: "mastiff", subBreeds: ["bull", "english", "tibetan"]),
          ]);

      final listBreeds = await breedsRepository.breedsList();

      expect(listBreeds, isNotEmpty);
      expect(listBreeds, isNotNull);
      expect(listBreeds.length, 4);
      expect(listBreeds.first.breed, "affenpinscher");
      expect(listBreeds.first.subBreeds.isEmpty, true);
      expect(listBreeds.last.breed, "mastiff");
      expect(listBreeds.last.subBreeds.isNotEmpty, true);
      expect(listBreeds.last.subBreeds.length, 3);
    });

    test("get error repository breedsList", () async {
      expect(() async => await breedsRepository.breedsList(),
          throwsA(isA<RepositoryError>()));
    });
  });

  group("testing method randomBreedImage", () {
    test("get random breed image", () async {
      const breed = "mastiff";

      when(service.getRandomBreedImage(breed)).thenAnswer((_) async =>
          const DogImageModel(message: "image_1.jpg", status: "success"));

      final urlImage = await breedsRepository.randomBreedImage(breed);

      expect(urlImage, isNotNull);
      expect(urlImage.message, "image_1.jpg");
      expect(urlImage.status, "success");
    });

    test("get error repository randomBreedImage", () async {
      const breed = "abcdef";

      expect(() async => await breedsRepository.randomBreedImage(breed),
          throwsA(isA<RepositoryError>()));
    });
  });

  group("testing method randomSub-BreedImage", () {
    test("get random sub-breed image", () async {
      const breed = "hound";
      const subBreed = "afghan";

      when(service.getRandomSubBreedImage(breed, subBreed)).thenAnswer(
          (_) async =>
              const DogImageModel(message: "image_1.jpg", status: "success"));

      final urlImage =
          await breedsRepository.randomSubBreedImage(breed, subBreed);

      expect(urlImage, isNotNull);
      expect(urlImage.message, "image_1.jpg");
      expect(urlImage.status, "success");
    });

    test("get error repository randomSubBreedImage", () async {
      const breed = "hound";
      const subBreed = "abcdef";

      expect(
          () async =>
              await breedsRepository.randomSubBreedImage(breed, subBreed),
          throwsA(isA<RepositoryError>()));
    });
  });

  group("testing method breedImagesList", () {
    test("get list breed images", () async {
      const breed = "mastiff";

      when(service.getBreedImagesList(breed)).thenAnswer((_) async =>
          const DogImagesModel(message: [
            "image_1.jpg",
            "image_2.jpg",
            "image_3.jpg",
            "image_4.jpg"
          ], status: "success"));

      final urlImage = await breedsRepository.breedImagesList(breed);

      expect(urlImage, isNotNull);
      expect(urlImage.message.isNotEmpty, true);
      expect(urlImage.status, "success");
      expect(urlImage.message.first, "image_1.jpg");
      expect(urlImage.message.last, "image_4.jpg");
      expect(urlImage.message.length, 4);
    });

    test("get error repository breedImagesList", () async {
      const breed = "abcdef";

      expect(() async => await breedsRepository.breedImagesList(breed),
          throwsA(isA<RepositoryError>()));
    });
  });

  group("testing method breedImagesList", () {
    test("get list breed images", () async {
      const breed = "hound";
      const subBreed = "afghan";

      when(service.getSubBreedImagesList(breed, subBreed)).thenAnswer(
          (_) async => const DogImagesModel(message: [
                "image_1.jpg",
                "image_2.jpg",
                "image_3.jpg",
                "image_4.jpg"
              ], status: "success"));

      final urlImage =
          await breedsRepository.subBreedImagesList(breed, subBreed);

      expect(urlImage, isNotNull);
      expect(urlImage.message.isNotEmpty, true);
      expect(urlImage.status, "success");
      expect(urlImage.message.first, "image_1.jpg");
      expect(urlImage.message.last, "image_4.jpg");
      expect(urlImage.message.length, 4);
    });

    test("get error repository breedImagesList", () async {
      const breed = "hound";
      const subBreed = "abcdef";

      expect(
          () async =>
              await breedsRepository.subBreedImagesList(breed, subBreed),
          throwsA(isA<RepositoryError>()));
    });
  });
}
