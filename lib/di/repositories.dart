part of 'dependency_injector.dart';

final List<RepositoryProvider> _repositories = [
  RepositoryProvider<BreedsRepository>(
    create: (context) => BreedsRepository(
      service: context.read<BreedsApiService>(),
    ),
  ),
];
