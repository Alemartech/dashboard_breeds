import 'package:bloc_test/bloc_test.dart';
import 'package:dashboard_breeds/blocs/breeds_list/breeds_list_bloc.dart';
import 'package:dashboard_breeds/blocs/dogs_images/dogs_images_bloc.dart';
import 'package:dashboard_breeds/pages/dashboard_breeds_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockBreedListBloc extends MockBloc<BreedsListEvent, BreedsListState>
    implements BreedsListBloc {}

class MockDogsImagesBloc extends MockBloc<DogsImagesEvent, DogsImagesState>
    implements DogsImagesBloc {}

void main() {
  testWidgets("test dashboard breeds page with error", (widgetTester) async {
    final breedListBloc = MockBreedListBloc();
    final dogsImagesBloc = MockDogsImagesBloc();

    whenListen(
      breedListBloc,
      Stream.fromIterable([
        BreedsFetchingState(),
        const BreedsFetchErrorState(errorMessage: "Custom error"),
      ]),
      initialState: BreedsFetchingState(),
    );

    await widgetTester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<BreedsListBloc>(
            create: (_) => breedListBloc,
          ),
          BlocProvider<DogsImagesBloc>(
            create: (_) => dogsImagesBloc,
          ),
        ],
        child: const MaterialApp(
          home: DashboardBreedsPage(),
        ),
      ),
    );

    await widgetTester.pumpAndSettle();
    expect(find.text("Error loading: Custom error"), findsOneWidget);
  });

  testWidgets("test dashboard breeds page with no image selected",
      (widgetTester) async {
    final breedListBloc = MockBreedListBloc();
    final dogsImagesBloc = MockDogsImagesBloc();

    whenListen(
      dogsImagesBloc,
      Stream.fromIterable([DogsImagesNoState()]),
    );

    await widgetTester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<BreedsListBloc>(
            create: (_) => breedListBloc,
          ),
          BlocProvider<DogsImagesBloc>(
            create: (_) => dogsImagesBloc,
          ),
        ],
        child: const MaterialApp(
          home: DashboardBreedsPage(),
        ),
      ),
    );

    await widgetTester.pumpAndSettle();
    expect(
        find.text(
            "No image selected. Please use search filter for display the images"),
        findsOneWidget);
  });
}
