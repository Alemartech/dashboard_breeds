import 'package:dashboard_breeds/errors/repository_error.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:dashboard_breeds/repositories/breeds_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'breeds_list_event.dart';
part 'breeds_list_state.dart';

class BreedsListBloc extends Bloc<BreedsListEvent, BreedsListState> {
  final BreedsRepository breedsRepository;

  BreedsListBloc({required this.breedsRepository})
      : super(BreedsFetchingState()) {
    on<BreedsListFetchEvent>(_fetchBreeds);
  }

  Future<void> _fetchBreeds(BreedsListFetchEvent event, Emitter emit) async {
    emit(BreedsFetchingState());

    try {
      final breeds = await breedsRepository.breedsList();
      emit(BreedsFetchedState(breeds: breeds));
    } on RepositoryError catch (e) {
      emit(BreedsFetchErrorState(errorMessage: e.errorMessage));
    } catch (error) {
      emit(const BreedsFetchErrorState());
    }
  }

  void getBreedsSubbreedsList() => add(BreedsListFetchEvent());
}
