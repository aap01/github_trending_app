import 'package:flutter/material.dart';
import 'package:github_favs/feature/common/presentation/widget/drawer_list_widget.dart';
import 'package:github_favs/feature/top_repo/presentation/widget/top_repo_list_widget.dart';
import 'package:github_favs/feature/top_user/presentation/widget/country_drop_down_widget.dart';
import 'package:github_favs/feature/top_user/presentation/widget/top_user_by_country_widget.dart';
import 'package:github_favs/feature/top_user/presentation/widget/total_result_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: SafeArea(
          child: DrawerListWidget(onTap: (index) {
            setState(() {
              _selectedPage = index;
            });
          }),
        ),
      ),
      body: SafeArea(
        child: _selectedPage == 0 ? _getTopUsers() : _getTopRepos(),
      ),
    );
  }

  CustomScrollView _getTopUsers() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Github Trending'),
        ),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              UserTotalResultWiget(),
              CountryDropDownWidget(),
            ],
          ),
        ),
        const TopUserByCountryWidget()
      ],
    );
  }

  CustomScrollView _getTopRepos() {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Github Trending'),
        ),
        TopRepoListWidget()
      ],
    );
  }
}
