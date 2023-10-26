import 'package:dashboard_breeds/di/dependency_injector.dart';
import 'package:dashboard_breeds/pages/dashboard_breeds_page.dart';
import 'package:dashboard_breeds/theme/theme_app_dashboard_breed.dart';
import 'package:flutter/material.dart';

class DashboardBreedsApp extends StatelessWidget {
  const DashboardBreedsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DependencyInjector(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeAppDashboardBreed.themeData,
        home: const DashboardBreedsPage(),
      ),
    );
  }
}
