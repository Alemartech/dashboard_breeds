part of 'breeds_list_bloc.dart';

abstract class BreedsListEvent extends Equatable {
  const BreedsListEvent();

  @override
  List<Object> get props => [];
}

class BreedsListFetchEvent extends BreedsListEvent {}
