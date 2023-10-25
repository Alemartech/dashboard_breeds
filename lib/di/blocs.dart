part of 'dependency_injector.dart';

final List<BlocProvider> _blocs = [
  BlocProvider<BreedsListBloc>(
    create: (context) => BreedsListBloc(
      breedsRepository: context.read<BreedsRepository>(),
    )..getBreedsSubbreedsList(),
  ),
  BlocProvider<DogsImagesBloc>(
    create: (context) => DogsImagesBloc(
      breedsRepository: context.read<BreedsRepository>(),
    ),
  ),
];
