import 'package:dashboard_breeds/blocs/breeds_list/breeds_list_bloc.dart';
import 'package:dashboard_breeds/repositories/breeds_repository.dart';
import 'package:dashboard_breeds/services/breeds_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pine/di/dependency_injector_helper.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

part 'blocs.dart';
part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;
  const DependencyInjector({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DependencyInjectorHelper(
      blocs: _blocs,
      providers: _providers,
      repositories: _repositories,
      child: child,
    );
  }
}
