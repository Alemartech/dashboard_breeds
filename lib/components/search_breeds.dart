import 'package:dashboard_breeds/blocs/dogs_images/dogs_images_bloc.dart';
import 'package:dashboard_breeds/components/button.dart';
import 'package:dashboard_breeds/components/dropdown.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:dashboard_breeds/theme/colors_references.dart';
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

  void _onChangeBreedsDropdown(String? value) {
    setState(() {
      if (value != dropdownBreedValue) dropdownSubBreedValue = null;
      dropdownBreedValue = value?.toString();
    });
  }

  void _onChangeSubBreedsDropdown(String? value) {
    setState(() {
      dropdownSubBreedValue = value?.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 36.0),
      child: Column(
        children: [
          Column(
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
        ],
      ),
    );
  }

  Widget _setTitleFilterField({required String title}) => Text(
        "$title:",
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: ColorsReferences.textColor,
        ),
      );

  Widget _dropDownBreeds() => Dropdown(
        hintText: "SELECT BREED",
        value: dropdownBreedValue,
        items: widget.breedsList
            .map<DropdownMenuItem<String>>(
              (breedList) => DropdownMenuItem<String>(
                value: breedList.breed,
                child: Text(breedList.breed.toUpperCase()),
              ),
            )
            .toList(),
        onChanged: (value) => _onChangeBreedsDropdown(value),
      );

  Widget _dropDownSubBreeds() => Dropdown(
        hintText: "SELECT SUB-BREED",
        disabledIintText: "NO SUBBREED AVAILABLE",
        value: dropdownSubBreedValue,
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
        onChanged: (value) => _onChangeSubBreedsDropdown(value),
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
