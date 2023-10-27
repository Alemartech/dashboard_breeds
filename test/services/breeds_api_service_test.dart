import 'dart:convert';

import 'package:dashboard_breeds/errors/network_error.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:dashboard_breeds/models/dog_image_model.dart';
import 'package:dashboard_breeds/models/dog_images_model.dart';
import 'package:dashboard_breeds/services/breeds_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([http.Client])
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  group("test method getBreedList", () {
    test(
        "return list of breeds and sub-breeds if the http call completes successfully",
        () async {
      final service = BreedsApiService();

      service.client = MockClient((request) async {
        final json = {
          'message': {
            'affenpinscher': [],
            'australian': ['shepherd'],
            'bulldog': ['boston', 'english', 'french']
          },
          'status': 'success'
        };

        return http.Response(jsonEncode(json), 200);
      });

      expect(await service.getBreedList(), isA<List<BreedModel>>());
    });

    test("throws an exception if the http client call completes with an error",
        () async {
      final service = BreedsApiService();

      service.client = MockClient((request) async {
        final json = {
          'message':
              'No route found for \"GET http://dog.ceo/api/breeds/listt/all\" with code: 0',
          'status': 'error'
        };

        return http.Response(jsonEncode(json), 200);
      });

      expect(() async => await service.getBreedList(),
          throwsA(isA<NetworkError>()));
    });

    test("throws an exception if the http server call completes with an error",
        () async {
      final service = BreedsApiService();

      service.client = MockClient((request) async {
        return http.Response("Server Unavailable", 503);
      });

      expect(() async => await service.getBreedList(),
          throwsA(isA<NetworkError>()));
    });
  });

  group("test method getRandomBreedImage", () {
    test("return random breed image if the http call completes successfully",
        () async {
      final service = BreedsApiService();
      final listBreeds = ["hound", "bulldog", "affenpinscher"];

      service.client = MockClient((request) async {
        final json = {'message': 'image_1.jpg', 'status': 'success'};

        return http.Response(jsonEncode(json), 200);
      });

      for (var breed in listBreeds) {
        expect(await service.getRandomBreedImage(breed), isA<DogImageModel>());
      }
    });

    test("throws an exception if the http server call completes with an error",
        () async {
      final service = BreedsApiService();

      service.client = MockClient((request) async {
        return http.Response("Server Unavailable", 503);
      });

      expect(() async => await service.getBreedList(),
          throwsA(isA<NetworkError>()));
    });
  });

  group("test method getBreedImagesList", () {
    test("return list breed images if the http call completes successfully",
        () async {
      final service = BreedsApiService();
      final listBreeds = ["hound", "bulldog", "affenpinscher"];

      service.client = MockClient((request) async {
        final json = {
          'message': ['image_1.jpg', 'image_2.jpg', 'image_3.jpg'],
          'status': 'success'
        };

        return http.Response(jsonEncode(json), 200);
      });

      for (var breed in listBreeds) {
        expect(await service.getBreedImagesList(breed), isA<DogImagesModel>());
      }
    });

    test("throws an exception if the http server call completes with an error",
        () async {
      final service = BreedsApiService();

      service.client = MockClient((request) async {
        return http.Response("Server Unavailable", 503);
      });

      expect(() async => await service.getBreedList(),
          throwsA(isA<NetworkError>()));
    });
  });

  group("test method getRandomSubBreedImage", () {
    test(
        "return random sub-breed image if the http call completes successfully",
        () async {
      final service = BreedsApiService();
      const breed = "bulldog";
      const subBreed = "english";

      service.client = MockClient((request) async {
        final json = {'message': 'image_1.jpg', 'status': 'success'};

        return http.Response(jsonEncode(json), 200);
      });

      expect(await service.getRandomSubBreedImage(breed, subBreed),
          isA<DogImageModel>());
    });

    test("throws an exception if the http server call completes with an error",
        () async {
      final service = BreedsApiService();

      service.client = MockClient((request) async {
        return http.Response("Server Unavailable", 503);
      });

      expect(() async => await service.getBreedList(),
          throwsA(isA<NetworkError>()));
    });
  });

  group("test method getSubBreedImagesList", () {
    test("return list sub-breed images if the http call completes successfully",
        () async {
      final service = BreedsApiService();
      const breed = "bulldog";
      const subBreed = "english";

      service.client = MockClient((request) async {
        final json = {
          'message': ['image_1.jpg', 'image_2.jpg', 'image_3.jpg'],
          'status': 'success'
        };

        return http.Response(jsonEncode(json), 200);
      });

      expect(await service.getSubBreedImagesList(breed, subBreed),
          isA<DogImagesModel>());
    });

    test("throws an exception if the http server call completes with an error",
        () async {
      final service = BreedsApiService();

      service.client = MockClient((request) async {
        return http.Response("Server Unavailable", 503);
      });

      expect(() async => await service.getBreedList(),
          throwsA(isA<NetworkError>()));
    });
  });
}
