import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_favs/feature/common/data/resource/srtin_resource.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/top_user/top_user_bloc.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/top_user/top_user_state.dart';

class UserTotalResultWiget extends StatelessWidget {
  const UserTotalResultWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<TopUserBloc, TopUserState>(
          builder: (context, state) {
            return Text('${StringResource.totalResult} ${state.totalCount}');
          },
        ),
      ],
    );
  }
}
