import 'dart:convert';

import 'package:github_users/core/error/exception.dart';
import 'package:github_users/core/helpers/my_loggers.dart';
import 'package:github_users/feature/users/data/models/users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  /// Gets the cached [List<PersonModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<UsersModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<UsersModel> persons);
}

// ignore: constant_identifier_names
const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<UsersModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList!.isNotEmpty) {
      logger.i('Get Users from Cache: ${jsonPersonsList.length}');
      return Future.value(jsonPersonsList
          .map((person) => UsersModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> personsToCache(List<UsersModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    logger.i('Users to write Cache: ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }
}

