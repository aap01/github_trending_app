import 'package:flutter/material.dart';

class DrawerListWidget extends StatefulWidget {
  final Function(int) onTap;
  const DrawerListWidget({super.key, required this.onTap});

  @override
  State<DrawerListWidget> createState() => _DrawerListWidgetState();
}

class _DrawerListWidgetState extends State<DrawerListWidget> {
  final List<String> _drawerItems = [
    'Top user by country',
    'Top repositories',
  ];
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: _drawerItems.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: _selected == index
                  ? theme.primaryColor
                  : theme.scaffoldBackgroundColor,
            ),
            child: Text(
              _drawerItems[index],
            ),
          ),
          onTap: () {
            widget.onTap(index);
            setState(() {
              _selected = index;
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}
