import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/user_details/user_details_state.dart';
import 'package:github_favs/feature/top_user/presentation/widget/user_avatar_widget.dart';
import 'package:github_favs/feature/top_user/presentation/widget/user_short_info_widget.dart';

class UserDetailsScreen extends StatefulWidget {
  final int id;
  const UserDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserDetailsBloc>().populateUserDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<UserDetailsBloc, UserDetailsSate>(
            builder: (cxt, state) {
          return state.map(
            initial: (value) {
              return const Center(child: CircularProgressIndicator());
            },
            loading: (value) {
              return const Center(child: CircularProgressIndicator());
            },
            loaded: (value) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    UserImageAvatar(
                      avatarUrl: value.userDetails.avatarUrl,
                    ),
                    const SizedBox(height: 10),
                    UserShortInfoWidget(
                      login: value.userDetails.login,
                      score: value.userDetails.score.toString(),
                    )
                  ],
                ),
              );
            },
            error: (value) {
              //TODO: move showing messege to listener
              final messenger = ScaffoldMessenger.of(cxt);
              messenger.hideCurrentSnackBar();
              messenger.showSnackBar(
                SnackBar(
                  content: Text(value.message),
                ),
              );
              return const SizedBox();
            },
          );
        }),
      ),
    );
  }
}
