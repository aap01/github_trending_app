import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  final Widget drawerChild;
  final Widget body;
  const AppScreen({
    super.key,
    required this.drawerChild,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Text('Github Trending')),
      drawer: Drawer(
        child: drawerChild,
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }
}
