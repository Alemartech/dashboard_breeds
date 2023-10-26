import 'package:dashboard_breeds/theme/colors_references.dart';
import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final String errorMessage;
  const CustomError({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(
        child: Text(
          "Error loading: $errorMessage",
          style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: ColorsReferences.errorText),
        ),
      ),
    );
  }
}
