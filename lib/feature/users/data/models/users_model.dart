import 'package:github_users/feature/users/domain/entities/users_entity.dart';

// class PersonModel extends PersonEntitiy {
//   const PersonModel({
//     required id,
//     required name,
//     required status,
//     required species,
//     required type,
//     required gender,
//     required origin,
//     required location,
//     required image,
//     required episode,
//     required created,
//   }) : super(
//           id: id,
//           name: name,
//           status: status,
//           species: species,
//           type: type,
//           gender: gender,
//           origin: origin,
//           location: location,
//           image: image,
//           episode: episode,
//           created: created,
//         );

//   factory PersonModel.fromJson(Map<String, dynamic> json) {
//     return PersonModel(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       status: json['status'] as String,
//       species: json['species'] as String,
//       type: json['type'] as String,
//       gender: json['gender'] as String,
//       origin: json['origin'] != null
//           ? LocationModel.fromJson(json['origin'])
//           : null,
//       location: json['location'] != null
//           ? LocationModel.fromJson(json['location'])
//           : null,
//       image: json['image'] as String,
//       episode:
//           (json['episode'] as List<dynamic>).map((e) => e).toList(),
//       created: DateTime.parse(json['created']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'status': status,
//       'species': species,
//       'type': type,
//       'gender': gender,
//       'origin': origin,
//       'location': location,
//       'image': image,
//       'episode': episode,
//       'created': created?.toIso8601String(),
//     };
//   }
// }



class UsersModel extends UsersEntity {
  const UsersModel({
    required super.login,
    required super.id,
    required super.nodeId,
    required super.avatarUrl,
    required super.gravatarId,
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
