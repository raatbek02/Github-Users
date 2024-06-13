import 'package:equatable/equatable.dart';

// class PersonEntity extends Equatable {
//   final int id;
//   final String name;
//   final String status;
//   final String species;
//   final String type;
//   final String gender;
//   final LocationEntity origin;
//   final LocationEntity location;
//   final String image;
//   final List<dynamic> episode;
//   final DateTime created;

//   const PersonEntity({
//     required this.id,
//     required this.name,
//     required this.status,
//     required this.species,
//     required this.type,
//     required this.gender,
//     required this.origin,
//     required this.location,
//     required this.image,
//     required this.episode,
//     required this.created,
//   });

//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         status,
//         species,
//         type,
//         gender,
//         origin,
//         location,
//         image,
//         episode,
//         created,
//       ];
// }

// class LocationEntity {
//   final String name;
//   final String url;

//   const LocationEntity({required this.name, required this.url});
// }



class UsersEntity extends Equatable {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
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
    required this.gravatarId,
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
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
      gravatarId: json['gravatar_id'],
      url: json['url'],
      htmlUrl: json['html_url'],
      followersUrl: json['followers_url'],
      followingUrl: json['following_url'],
      gistsUrl: json['gists_url'],
      starredUrl: json['starred_url'],
      subscriptionsUrl: json['subscriptions_url'],
      organizationsUrl: json['organizations_url'],
      reposUrl: json['repos_url'],
      eventsUrl: json['events_url'],
      receivedEventsUrl: json['received_events_url'],
      type: json['type'],
      siteAdmin: json['site_admin'],
    );
  }

  @override
  List<Object?> get props => [
        login,
        id,
        nodeId,
        avatarUrl,
        gravatarId,
        url,
        htmlUrl,
        followersUrl,
        followingUrl,
        gistsUrl,
        starredUrl,
        subscriptionsUrl,
        organizationsUrl,
        reposUrl,
        eventsUrl,
        receivedEventsUrl,
        type,
        siteAdmin,
      ];
}
