import 'package:dashboard_breeds/models/breeds_model.dart';
import 'package:dashboard_breeds/services/breeds_api_service.dart';

class BreedsRepository {
  final BreedsApiService service;

  BreedsRepository({required this.service});

  Future<BreedsModel> subBreedList(String breed, String subBreed) async {
    final response = await service.getSubBreedList(breed, subBreed);

    return response;
  }
}
