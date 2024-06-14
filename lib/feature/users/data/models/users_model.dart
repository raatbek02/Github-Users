import 'package:github_users/feature/users/domain/entities/users_entity.dart';



class UsersModel extends UsersEntity {
  const UsersModel({
    required super.login,
    required super.id,
    required super.nodeId,
    required super.avatarUrl,
    super.gravatarId,
    required super.url,
    required super.htmlUrl,
    required super.followersUrl,
    required super.followingUrl,
    required super.gistsUrl,
    required super.starredUrl,
    required super.subscriptionsUrl,
    required super.organizationsUrl,
    required super.reposUrl,
    required super.eventsUrl,
    required super.receivedEventsUrl,
    required super.type,
    required super.siteAdmin,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      login: json['login'] as String,
      id: json['id'] as int,
      nodeId: json['node_id'] as String,
      avatarUrl: json['avatar_url'] as String,
      gravatarId: json['gravatar_id'] as String?,
      url: json['url'] as String,
      htmlUrl: json['html_url'] as String,
      followersUrl: json['followers_url'] as String,
      followingUrl: json['following_url'] as String,
      gistsUrl: json['gists_url'] as String,
      starredUrl: json['starred_url'] as String,
      subscriptionsUrl: json['subscriptions_url'] as String,
      organizationsUrl: json['organizations_url'] as String,
      reposUrl: json['repos_url'] as String,
      eventsUrl: json['events_url'] as String,
      receivedEventsUrl: json['received_events_url'] as String,
      type: json['type'] as String,
      siteAdmin: json['site_admin'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'node_id': nodeId,
      'avatar_url': avatarUrl,
      'gravatar_id': gravatarId,
      'url': url,
      'html_url': htmlUrl,
      'followers_url': followersUrl,
      'following_url': followingUrl,
      'gists_url': gistsUrl,
      'starred_url': starredUrl,
      'subscriptions_url': subscriptionsUrl,
      'organizations_url': organizationsUrl,
      'repos_url': reposUrl,
      'events_url': eventsUrl,
      'received_events_url': receivedEventsUrl,
      'type': type,
      'site_admin': siteAdmin,
    };
  }
}
