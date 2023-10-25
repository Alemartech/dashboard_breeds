part of 'breeds_list_bloc.dart';

abstract class BreedsListState extends Equatable {
  const BreedsListState();

  @override
  List<Object?> get props => [];
}

class BreedsFetchingState extends BreedsListState {}

class BreedsFetchedState extends BreedsListState {
  final List<BreedModel>? breeds;

  const BreedsFetchedState({required this.breeds});

  @override
  List<Object> get props => [breeds ?? []];
}

class BreedsFetchErrorState extends BreedsListState {
  final String? errorMessage;

  const BreedsFetchErrorState({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
