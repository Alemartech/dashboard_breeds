import 'package:dashboard_breeds/blocs/dogs_images/dogs_images_bloc.dart';
import 'package:dashboard_breeds/components/button.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBreeds extends StatefulWidget {
  final List<BreedModel> breedsList;

  const SearchBreeds({Key? key, required this.breedsList}) : super(key: key);

  @override
  State<SearchBreeds> createState() => _SearchBreedsState();
}

class _SearchBreedsState extends State<SearchBreeds> {
  final double maxDropdownHeight = 200.0;
  String? dropdownBreedValue;
  String? dropdownSubBreedValue;

  void _getRandomImage(BuildContext context) async {
    if (dropdownSubBreedValue != null) {
      context.read<DogsImagesBloc>().getDogSubBreedRandomImage(
          dropdownBreedValue!, dropdownSubBreedValue!);
    } else {
      context
          .read<DogsImagesBloc>()
          .getDogBreedRandomImage(dropdownBreedValue!);
    }
  }

  void _getListImages(BuildContext context) async {
    if (dropdownSubBreedValue != null) {
      context.read<DogsImagesBloc>().getDogSubBreedListImages(
          dropdownBreedValue!, dropdownSubBreedValue!);
    } else {
      context.read<DogsImagesBloc>().getDogBreedListImages(dropdownBreedValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      //  height: 600,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _setTitleFilterField(title: "Select Breed"),
                  _dropDownBreeds(),
                ],
              )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _setTitleFilterField(title: "Select SubBreed"),
                    _dropDownSubBreeds(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _actionsButtons(),
          ),
        ],
      ),
    );
  }

  Widget _setTitleFilterField({required String title}) => Text(
        "$title:",
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _dropDownBreeds() => DropdownButton(
        value: dropdownBreedValue,
        menuMaxHeight: maxDropdownHeight,
        hint: const Text(
          "SELECT BREED",
          style: TextStyle(color: Colors.grey),
        ),
        style: const TextStyle(fontSize: 12.0, color: Colors.black),
        items: widget.breedsList
            .map<DropdownMenuItem<String>>(
              (breedList) => DropdownMenuItem<String>(
                value: breedList.breed,
                child: Text(breedList.breed.toUpperCase()),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value != dropdownBreedValue) dropdownSubBreedValue = null;
            dropdownBreedValue = value?.toString();
          });
        },
      );

  Widget _dropDownSubBreeds() => DropdownButton(
        value: dropdownSubBreedValue,
        menuMaxHeight: maxDropdownHeight,
        hint: const Text(
          "SELECT SUB-BREED",
          style: TextStyle(color: Colors.grey),
        ),
        style: const TextStyle(fontSize: 12.0, color: Colors.black),
        items: dropdownBreedValue != null
            ? widget.breedsList
                .where((breedElem) => breedElem.breed == dropdownBreedValue)
                .first
                .subBreeds
                .map<DropdownMenuItem<String>>(
                  (subBreed) => DropdownMenuItem<String>(
                    value: subBreed,
                    child: Text(subBreed.toUpperCase()),
                  ),
                )
                .toList()
            : null,
        onChanged: (value) {
          setState(() {
            dropdownSubBreedValue = value.toString();
          });
        },
      );

  Widget _actionsButtons() => BlocBuilder<DogsImagesBloc, DogsImagesState>(
        builder: (dogsImagesContext, dogsImagesState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                width: 150.0,
                disabled: dropdownBreedValue == null,
                title: "Get Random Image",
                onPressed: () => _getRandomImage(dogsImagesContext),
              ),
              Button(
                width: 150.0,
                disabled: dropdownBreedValue == null,
                title: "Get List Images",
                onPressed: () => _getListImages(dogsImagesContext),
              ),
            ],
          );
        },
      );
}
