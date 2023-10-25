part of 'dependency_injector.dart';

final List<BlocProvider> _blocs = [
  BlocProvider<BreedsListBloc>(
    create: (context) => BreedsListBloc(
      breedsRepository: context.read<BreedsRepository>(),
    )..getBreedsSubbreedsList(),
  ),
];
