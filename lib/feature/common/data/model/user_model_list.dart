import 'package:github_favs/feature/common/data/model/user_model.dart';

class UserModelList {
  int? totalCount;
  List<UserModel>? items;

  UserModelList({
    this.totalCount,
    this.items,
  });

  UserModelList.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['items'] != null) {
      items = <UserModel>[];
      json['items'].forEach((v) {
        items?.add(UserModel.fromJson(v));
      });
    }
  }
}
