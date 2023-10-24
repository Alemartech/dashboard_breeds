import 'dart:convert';

import 'package:dashboard_breeds/errors/network_error.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:dashboard_breeds/models/breeds_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BreedsApiService {
  Future<BreedsModel> getSubBreedList(String breed, String subBreed) async {
    final baseUrl = dotenv.env['BREEDS_API_BASE_URL'].toString();
    final response =
        await http.post(Uri.parse("$baseUrl/$breed/$subBreed/list"));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      return BreedsModel.fromJson(jsonBody);
    } else {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }
  }

  Future<BreedModel> getRandomBreedImage(String breed) async {
    final baseUrl = dotenv.env['BREEDS_API_BASE_URL'].toString();
    final response =
        await http.post(Uri.parse("$baseUrl/$breed/images/random"));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      return BreedModel.fromJson(jsonBody);
    } else {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }
  }

  Future<BreedsModel> getBreedsImagesList(String breed) async {
    final baseUrl = dotenv.env['BREEDS_API_BASE_URL'].toString();
    final response = await http.post(Uri.parse("$baseUrl/$breed/images"));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      return BreedsModel.fromJson(jsonBody);
    } else {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }
  }

  Future<BreedModel> getRandomSubBreedImage(
      String breed, String subBreed) async {
    final baseUrl = dotenv.env['BREEDS_API_BASE_URL'].toString();
    final response =
        await http.post(Uri.parse("$baseUrl/$breed/$subBreed/images/random"));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      return BreedModel.fromJson(jsonBody);
    } else {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }
  }

  Future<BreedsModel> getSubBreedsImagesList(
      String breed, String subBreed) async {
    final baseUrl = dotenv.env['BREEDS_API_BASE_URL'].toString();
    final response =
        await http.post(Uri.parse("$baseUrl/$breed/$subBreed/images"));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      return BreedsModel.fromJson(jsonBody);
    } else {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }
  }
}
