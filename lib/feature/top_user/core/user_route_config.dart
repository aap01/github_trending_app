import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:github_favs/feature/top_user/presentation/screen/user_details_screen.dart';

abstract class UserRouteConfig {
  static const userDetails = '/userDetails';
  static final _sl = GetIt.instance;
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case userDetails:
        return _getUserDetailsRoute(routeSettings);
    }
    return null;
  }

  static Route _getUserDetailsRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (cxt) => MultiBlocProvider(
        providers: [
          BlocProvider<UserDetailsBloc>(
            create: (cxt) => _sl<UserDetailsBloc>(),
          ),
        ],
        child: UserDetailsScreen(
          id: settings.arguments as int,
        ),
      ),
      fullscreenDialog: true,
    );
  }
}
