part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<BreedsApiService>(
    create: (_) => BreedsApiService(),
  )
];
