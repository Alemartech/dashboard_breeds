import 'package:dashboard_breeds/blocs/breeds_list/breeds_list_bloc.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBreedsPage extends StatelessWidget {
  const DashboardBreedsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyDashBoard(),
    );
  }

  Widget _bodyDashBoard() => BlocBuilder<BreedsListBloc, BreedsListState>(
        builder: (breedsListContext, breedsListState) {
          if (breedsListState is BreedsFetchingState) {
            return _loading();
          } else if (breedsListState is BreedsFetchErrorState) {
            return _error(breedsListState.errorMessage ?? "Errore");
          } else if (breedsListState is BreedsFetchedState) {}
          return _fetchedBreeds(
              (breedsListState as BreedsFetchedState).breeds ?? []);
        },
      );

  Widget _loading() => const Center(
        child: CircularProgressIndicator(),
      );

  //TBD: non restituisco errore in questa fase ma setto le picklist con nessuna opzione disponibile
  Widget _error(String errorMsg) => Center(
        child: Text("Errore durante il caricamento: $errorMsg"),
      );

  Widget _fetchedBreeds(List<BreedModel> breeds) => SingleChildScrollView(
        child: Column(
          children: List.generate(
              breeds.length,
              (index) => Column(
                    children: [
                      const Text(
                        "Razza del cane:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(breeds[index].breed.toUpperCase()),
                      const Text(
                        "SottoRazza del cane:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ...List.generate(
                        breeds[index].subBreeds.length,
                        (indexSubBreeds) => Text(
                          breeds[index].subBreeds[indexSubBreeds].toUpperCase(),
                        ),
                      ),
                    ],
                  )),
        ),
      );
}
