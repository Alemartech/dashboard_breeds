import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_breeds/blocs/breeds_list/breeds_list_bloc.dart';
import 'package:dashboard_breeds/blocs/dogs_images/dogs_images_bloc.dart';
import 'package:dashboard_breeds/components/search_breeds.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBreedsPage extends StatefulWidget {
  const DashboardBreedsPage({Key? key}) : super(key: key);

  @override
  State<DashboardBreedsPage> createState() => _DashboardBreedsPageState();
}

class _DashboardBreedsPageState extends State<DashboardBreedsPage> {
  int currentPage = 0;
  final PageController _controller = PageController();
  int itemsNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _bodyDashBoard(),
      ),
    );
  }

  Widget _bodyDashBoard() => BlocBuilder<BreedsListBloc, BreedsListState>(
        builder: (breedsListContext, breedsListState) {
          if (breedsListState is BreedsFetchErrorState) {
            return _error(breedsListState.errorMessage ?? "Errore");
          } else if (breedsListState is BreedsFetchedState) {
            return _fetchedBreeds(breedsList: breedsListState.breeds ?? []);
          }
          return _loading();
        },
      );

  Widget _fetchedBreeds({required List<BreedModel> breedsList}) => Column(
        children: [
          Expanded(
              child: BlocConsumer<DogsImagesBloc, DogsImagesState>(
            builder: (dogsImageContext, dogsImageState) {
              if (dogsImageState is DogsImagesNoState) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      "No image selected. Please use search filter for display the images",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              } else if (dogsImageState is DogErrorImagesState) {
                return _error(
                    dogsImageState.errorMessage ?? "Connection Error");
              } else if (dogsImageState is DogsRandomImageState) {
                return _viewRandomImage(dogsImageState.dogImage.message);
              } else if (dogsImageState is DogListImagesState) {
                return _viewListImages(dogsImageState.dogImages.message);
              }

              return _loading();
            },
            listener: (context, dogsImageState) {
              if (dogsImageState is DogListImagesState) {
                setState(() {
                  currentPage = 0;
                  itemsNumber = dogsImageState.dogImages.message.length;
                });
              } else {
                setState(() {
                  itemsNumber = 0;
                });
              }
            },
          )),
          if (itemsNumber > 0) _indicatorPageView(),
          const SizedBox(height: 16.0),
          const Divider(
            thickness: 1.0,
          ),
          SearchBreeds(breedsList: breedsList),
        ],
      );

  Widget _viewRandomImage(String imageUrl) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(value: progress.progress)),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      );

  Widget _viewListImages(List<String> imagesUrl) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: PageView.builder(
          controller: _controller,
          itemCount: imagesUrl.length,
          itemBuilder: (context, index) => CachedNetworkImage(
            imageUrl: imagesUrl[index],
            progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(value: progress.progress)),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          onPageChanged: (value) => setState(() {
            currentPage = value;
          }),
        ),
      );

  Widget _indicatorPageView() => Text(
        "(${currentPage + 1} of $itemsNumber)",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey.shade500),
      );

  Widget _loading() => const Center(
        child: CircularProgressIndicator(),
      );

  //TBD: non restituisco errore in questa fase ma setto le picklist con nessuna opzione disponibile
  Widget _error(String errorMsg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Text(
            "Error loading: $errorMsg",
            style: const TextStyle(
                fontSize: 24.0, fontWeight: FontWeight.w500, color: Colors.red),
          ),
        ),
      );
}
