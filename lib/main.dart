import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_favs/core/dependency/app_dependency.dart';
import 'package:github_favs/core/presentation/rotue/route_config.dart';
import 'package:github_favs/feature/top_user/core/dependency.dart';

void main() async {
  final sl = GetIt.instance;
  await AppDependency(sl: sl).init();
  await TopUserDepencency(sl: sl).init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RouteConfig.getHomePage(),
      onGenerateRoute: RouteConfig.onGenerateRoute,
    );
  }
}
