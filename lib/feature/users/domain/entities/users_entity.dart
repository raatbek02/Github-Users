import 'package:equatable/equatable.dart';




class UsersEntity {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String? gravatarId;
  final String url;
  final String htmlUrl;
  final String followersUrl;
  final String followingUrl;
  final String gistsUrl;
  final String starredUrl;
  final String subscriptionsUrl;
  final String organizationsUrl;
  final String reposUrl;
  final String eventsUrl;
  final String receivedEventsUrl;
  final String type;
  final bool siteAdmin;

  const UsersEntity({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.siteAdmin,
  });

  factory UsersEntity.fromJson(Map<String, dynamic> json) {
    return UsersEntity(
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
}

// class UsersEntity extends Equatable {
//   final String login;
//   final int id;
//   final String nodeId;
//   final String avatarUrl;
//   final String gravatarId;
//   final String url;
//   final String htmlUrl;
//   final String followersUrl;
//   final String followingUrl;
//   final String gistsUrl;
//   final String starredUrl;
//   final String subscriptionsUrl;
//   final String organizationsUrl;
//   final String reposUrl;
//   final String eventsUrl;
//   final String receivedEventsUrl;
//   final String type;
//   final bool siteAdmin;

//   const UsersEntity({
//     required this.login,
//     required this.id,
//     required this.nodeId,
//     required this.avatarUrl,
//     required this.gravatarId,
//     required this.url,
//     required this.htmlUrl,
//     required this.followersUrl,
//     required this.followingUrl,
//     required this.gistsUrl,
//     required this.starredUrl,
//     required this.subscriptionsUrl,
//     required this.organizationsUrl,
//     required this.reposUrl,
//     required this.eventsUrl,
//     required this.receivedEventsUrl,
//     required this.type,
//     required this.siteAdmin,
//   });

//   factory UsersEntity.fromJson(Map<String, dynamic> json) {
//     return UsersEntity(
//       login: json['login'],
//       id: json['id'],
//       nodeId: json['node_id'],
//       avatarUrl: json['avatar_url'],
//       gravatarId: json['gravatar_id'],
//       url: json['url'],
//       htmlUrl: json['html_url'],
//       followersUrl: json['followers_url'],
//       followingUrl: json['following_url'],
//       gistsUrl: json['gists_url'],
//       starredUrl: json['starred_url'],
//       subscriptionsUrl: json['subscriptions_url'],
//       organizationsUrl: json['organizations_url'],
//       reposUrl: json['repos_url'],
//       eventsUrl: json['events_url'],
//       receivedEventsUrl: json['received_events_url'],
//       type: json['type'],
//       siteAdmin: json['site_admin'],
//     );
//   }

//   @override
//   List<Object?> get props => [
//         login,
//         id,
//         nodeId,
//         avatarUrl,
//         gravatarId,
//         url,
//         htmlUrl,
//         followersUrl,
//         followingUrl,
//         gistsUrl,
//         starredUrl,
//         subscriptionsUrl,
//         organizationsUrl,
//         reposUrl,
//         eventsUrl,
//         receivedEventsUrl,
//         type,
//         siteAdmin,
//       ];
// }
