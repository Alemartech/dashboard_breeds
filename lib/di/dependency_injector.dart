import 'package:flutter/material.dart';
import 'package:pine/di/dependency_injector_helper.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;
  const DependencyInjector({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DependencyInjectorHelper(child: child);
  }
}
