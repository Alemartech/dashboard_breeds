import 'package:dashboard_breeds/errors/network_error.dart';
import 'package:dashboard_breeds/errors/repository_error.dart';
import 'package:dashboard_breeds/models/dog_image_model.dart';
import 'package:dashboard_breeds/models/dog_images_model.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:dashboard_breeds/services/breeds_api_service.dart';

class BreedsRepository {
  final BreedsApiService service;

  BreedsRepository({required this.service});

  Future<List<BreedModel>> breedsList() async {
    try {
      final response = await service.getBreedList();

      return response;
    } on NetworkError catch (e, stack) {
      throw RepositoryError(e.reasonPhrase, stack.toString());
    } catch (e) {
      throw RepositoryError(e.toString());
    }
  }

  Future<DogImageModel> randomBreedImage(String breed) async {
    try {
      final response = await service.getRandomBreedImage(breed);

      return response;
    } on NetworkError catch (e, stack) {
      throw RepositoryError(e.reasonPhrase, stack.toString());
    } catch (e) {
      throw RepositoryError(e.toString());
    }
  }

  Future<DogImagesModel> breedImagesList(String breed) async {
    try {
      final response = await service.getBreedImagesList(breed);

      return response;
    } on NetworkError catch (e, stack) {
      throw RepositoryError(e.reasonPhrase, stack.toString());
    } catch (e) {
      throw RepositoryError(e.toString());
    }
  }

  Future<DogImageModel> randomSubBreedImage(
      String breed, String subBreed) async {
    try {
      final response = await service.getRandomSubBreedImage(breed, subBreed);

      return response;
    } on NetworkError catch (e, stack) {
      throw RepositoryError(e.reasonPhrase, stack.toString());
    } catch (e) {
      throw RepositoryError(e.toString());
    }
  }

  Future<DogImagesModel> subBreedImagesList(
      String breed, String subBreed) async {
    try {
      final response = await service.getSubBreedImagesList(breed, subBreed);

      return response;
    } on NetworkError catch (e, stack) {
      throw RepositoryError(e.reasonPhrase, stack.toString());
    } catch (e) {
      throw RepositoryError(e.toString());
    }
  }
}
