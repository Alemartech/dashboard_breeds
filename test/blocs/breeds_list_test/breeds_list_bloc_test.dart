import 'package:bloc_test/bloc_test.dart';
import 'package:dashboard_breeds/blocs/breeds_list/breeds_list_bloc.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:dashboard_breeds/repositories/breeds_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'breeds_list_bloc_test.mocks.dart';

@GenerateMocks([BreedsRepository])
void main() {
  late BreedsRepository breedsRepository;

  setUp(() => breedsRepository = MockBreedsRepository());

  blocTest<BreedsListBloc, BreedsListState>(
    "getting list breeds and sub-breeds for dropdown button",
    setUp: () =>
        when(breedsRepository.breedsList()).thenAnswer((_) async => const [
              BreedModel(breed: "affenpinscher", subBreeds: []),
              BreedModel(breed: "australian", subBreeds: ["shepherd"]),
              BreedModel(breed: "bullterrier", subBreeds: ["staffordshire"]),
              BreedModel(
                  breed: "mastiff", subBreeds: ["bull", "english", "tibetan"]),
            ]),
    build: () => BreedsListBloc(breedsRepository: breedsRepository),
    act: (bloc) => bloc.getBreedsSubbreedsList(),
    expect: () => [
      BreedsFetchingState(),
      const BreedsFetchedState(breeds: [
        BreedModel(breed: "affenpinscher", subBreeds: []),
        BreedModel(breed: "australian", subBreeds: ["shepherd"]),
        BreedModel(breed: "bullterrier", subBreeds: ["staffordshire"]),
        BreedModel(breed: "mastiff", subBreeds: ["bull", "english", "tibetan"]),
      ]),
    ],
  );

  blocTest<BreedsListBloc, BreedsListState>(
    "getting empty list breeds and sub-breeds for dropdown button",
    setUp: () =>
        when(breedsRepository.breedsList()).thenAnswer((_) async => const []),
    build: () => BreedsListBloc(breedsRepository: breedsRepository),
    act: (bloc) => bloc.getBreedsSubbreedsList(),
    expect: () => [
      BreedsFetchingState(),
      const BreedsFetchedState(breeds: []),
    ],
  );

  blocTest<BreedsListBloc, BreedsListState>(
    "throwing an error while getting list breeds and sub-breeds",
    setUp: () => when(breedsRepository.breedsList()).thenThrow(Error()),
    build: () => BreedsListBloc(breedsRepository: breedsRepository),
    act: (bloc) => bloc.getBreedsSubbreedsList(),
    expect: () => [
      BreedsFetchingState(),
      isA<BreedsFetchErrorState>(),
    ],
  );
}
