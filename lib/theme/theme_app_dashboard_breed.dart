import 'package:dashboard_breeds/theme/colors_references.dart';
import 'package:flutter/material.dart';

class ThemeAppDashboardBreed {
  static ThemeData get themeData => ThemeData(
        fontFamily: "Nunito",
        scaffoldBackgroundColor: ColorsReferences.scaffoldBackgroundColor,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: ColorsReferences.accentColor),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(ColorsReferences.buttonColor),
            foregroundColor:
                MaterialStatePropertyAll(ColorsReferences.textColor),
          ),
        ),
      );
}
