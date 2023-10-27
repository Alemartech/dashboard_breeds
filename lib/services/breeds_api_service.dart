import 'dart:convert';

import 'package:dashboard_breeds/errors/network_error.dart';
import 'package:dashboard_breeds/models/dog_image_model.dart';
import 'package:dashboard_breeds/models/dog_images_model.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BreedsApiService {
  http.Client client = http.Client();

  Future<List<BreedModel>> getBreedList() async {
    final baseUrl = dotenv.env['BREEDS_LIST_BASE_URL'].toString();
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      if (jsonBody["status"] == "success") {
        List<BreedModel> breeds = [];
        (jsonBody["message"] as Map<String, dynamic>).forEach(
            (key, value) => breeds.add(BreedModel.fromMap(key, value)));

        return breeds;
      } else {
        throw NetworkError(500, jsonBody["message"]);
      }
    } else {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }
  }

  Future<DogImageModel> getRandomBreedImage(String breed) async {
    final baseUrl = dotenv.env['BREEDS_API_BASE_URL'].toString();
    final response =
        await client.get(Uri.parse("$baseUrl/$breed/images/random"));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      return DogImageModel.fromJson(jsonBody);
    } else {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }
  }

  Future<DogImagesModel> getBreedImagesList(String breed) async {
    final baseUrl = dotenv.env['BREEDS_API_BASE_URL'].toString();
    final response = await client.get(Uri.parse("$baseUrl/$breed/images"));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      return DogImagesModel.fromJson(jsonBody);
    } else {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }
  }

  Future<DogImageModel> getRandomSubBreedImage(
      String breed, String subBreed) async {
    final baseUrl = dotenv.env['BREEDS_API_BASE_URL'].toString();
    final response =
        await client.get(Uri.parse("$baseUrl/$breed/$subBreed/images/random"));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      return DogImageModel.fromJson(jsonBody);
    } else {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }
  }

  Future<DogImagesModel> getSubBreedImagesList(
      String breed, String subBreed) async {
    final baseUrl = dotenv.env['BREEDS_API_BASE_URL'].toString();
    final response =
        await client.get(Uri.parse("$baseUrl/$breed/$subBreed/images"));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      return DogImagesModel.fromJson(jsonBody);
    } else {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }
  }
}
