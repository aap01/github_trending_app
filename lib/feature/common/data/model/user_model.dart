import 'package:github_favs/core/data/model/model.dart';

class UserModel extends Model {
  String? login;
  String? nodeid;
  String? avatarurl;
  String? gravatarid;
  String? url;
  String? htmlurl;
  String? followersurl;
  String? followingurl;
  String? gistsurl;
  String? starredurl;
  String? subscriptionsurl;
  String? organizationsurl;
  String? reposurl;
  String? eventsurl;
  String? receivedeventsurl;
  String? type;
  bool? siteadmin;
  double? score;

  UserModel({
    this.login,
    required super.id,
    this.nodeid,
    this.avatarurl,
    this.gravatarid,
    this.url,
    this.htmlurl,
    this.followersurl,
    this.followingurl,
    this.gistsurl,
    this.starredurl,
    this.subscriptionsurl,
    this.organizationsurl,
    this.reposurl,
    this.eventsurl,
    this.receivedeventsurl,
    this.type,
    this.siteadmin,
    this.score,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'],
      id: json['id']!,
      nodeid: json['node_id'],
      avatarurl: json['avatar_url'],
      gravatarid: json['gravatar_id'],
      url: json['url'],
      htmlurl: json['html_url'],
      followersurl: json['followers_url'],
      followingurl: json['following_url'],
      gistsurl: json['gists_url'],
      starredurl: json['starred_url'],
      subscriptionsurl: json['subscriptions_url'],
      organizationsurl: json['organizations_url'],
      reposurl: json['repos_url'],
      eventsurl: json['events_url'],
      receivedeventsurl: json['received_events_url'],
      type: json['type'],
      siteadmin: json['site_admin'],
      score: json['score'],
    );
  }
}
