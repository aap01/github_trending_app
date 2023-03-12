import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_favs/feature/common/presentation/screen/dashboard_screen.dart';
import 'package:github_favs/feature/top_user/core/user_route_config.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/country_list/country_list_bloc.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/top_user/top_user_bloc.dart';

abstract class RouteConfig {
  static final sl = GetIt.instance;

  static const home = '/';
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final userRoute = UserRouteConfig.onGenerateRoute(routeSettings);
    if (userRoute != null) {
      return userRoute;
    }
    return MaterialPageRoute(builder: (cxt) => getHomePage());
  }

  static Widget getHomePage() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopUserBloc>(
          create: (cxt) => sl<TopUserBloc>(),
        ),
        BlocProvider<CountryListBloc>(
          create: (cxt) => sl<CountryListBloc>(),
        ),
      ],
      child: const MyHomePage(),
    );
  }
}
