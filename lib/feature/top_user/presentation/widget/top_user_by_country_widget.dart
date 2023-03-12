import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_favs/feature/common/domain/entity/user_entity.dart';
import 'package:github_favs/feature/top_user/core/user_route_config.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/top_user/top_user_bloc.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/top_user/top_user_state.dart';
import 'package:github_favs/feature/top_user/presentation/widget/user_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TopUserByCountryWidget extends StatefulWidget {
  const TopUserByCountryWidget({super.key});

  @override
  State<TopUserByCountryWidget> createState() => _TopUserByCountryWidgetState();
}

class _TopUserByCountryWidgetState extends State<TopUserByCountryWidget> {
  int _countryId = 1;
  final PagingController<int, UserEntity> _pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final bloc = context.read<TopUserBloc>();
    _pagingController.addPageRequestListener(
      (pageKey) async {
        await bloc.loadMoreUsers();
      },
    );
    bloc.loadInitialUserList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopUserBloc, TopUserState>(listener: (cxt, state) {
      if (state.lastPage) {
        _pagingController.appendLastPage(
          state.userList,
        );
      } else {
        _pagingController.appendPage(
          state.userList,
          state.page * 10 + state.userList.length,
        );
      }
      if (state.errorMessage.isNotEmpty) {
        _pagingController.error = state.errorMessage;
      }
      if (state.countryId != _countryId) {
        setState(() {
          _countryId = state.countryId;
          _pagingController.itemList?.clear();
        });
      }
    }, builder: (context, state) {
      return PagedSliverGrid<int, UserEntity>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (_, item, index) {
            return UserWidget(
              userEntity: item,
              onTap: (int id) {
                Navigator.of(context).pushNamed(
                  UserRouteConfig.userDetails,
                  arguments: id,
                );
              },
            );
          },
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 2,
          crossAxisCount: 2,
        ),
      );
    });
  }
}
