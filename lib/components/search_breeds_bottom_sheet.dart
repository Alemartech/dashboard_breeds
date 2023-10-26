import 'package:dashboard_breeds/components/search_breeds.dart';
import 'package:dashboard_breeds/models/breed_model.dart';
import 'package:dashboard_breeds/theme/colors_references.dart';
import 'package:flutter/material.dart';

class SearchBreedsBottomSheet extends StatefulWidget {
  final List<BreedModel> breedsList;
  const SearchBreedsBottomSheet({Key? key, required this.breedsList})
      : super(key: key);

  @override
  State<SearchBreedsBottomSheet> createState() =>
      _SearchBreedsBottomSheetState();
}

class _SearchBreedsBottomSheetState extends State<SearchBreedsBottomSheet> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    final currentSize = _controller.size;
    if (currentSize <= 0.05) _collapse();
  }

  void _collapse() => _animateSheet(sheet.snapSizes!.first);

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  DraggableScrollableSheet get sheet =>
      (_sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => DraggableScrollableSheet(
        key: _sheet,
        initialChildSize: 0.05,
        maxChildSize: 0.36,
        minChildSize: 0,
        expand: true,
        snap: true,
        snapSizes: const [0.05],
        controller: _controller,
        builder: (context, scrollController) => DecoratedBox(
          decoration: const BoxDecoration(
            color: ColorsReferences.backgroundsearchBreedBottomSheet,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                _toggleButtonBottomSheet(),
                SearchBreeds(breedsList: widget.breedsList),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toggleButtonBottomSheet() => Container(
        width: 100.0,
        height: 7.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: ColorsReferences.accentColor,
        ),
      );
}
