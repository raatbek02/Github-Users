import 'dart:convert';

import 'package:github_users/core/error/exception.dart';
import 'package:github_users/feature/users/data/models/users_detail_model.dart';
import 'package:github_users/feature/users/data/models/users_model.dart';
import 'package:http/http.dart' as http;

abstract class UsersRemoteDataSource {
  Future<List<UsersModel>> getUsersList(int page);
  Future<UserDetailModel> getDetailUser(String link);

}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final http.Client client;

  UsersRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UsersModel>> getUsersList(int page) =>
      _getPersonFromUrl('https://api.github.com/users');


  Future<List<UsersModel>> _getPersonFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons as List)
          .map((person) => UsersModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
  
@override
  Future<UserDetailModel> getDetailUser(String link) async {
    final response = await client
        .get(Uri.parse(link), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final person = json.decode(response.body);
      return UserDetailModel.fromJson(person);
    } else {
      throw ServerException();
    }
  }

}




  // @override
  // Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl(
  //     'https://rickandmortyapi.com/api/character/?page=$page');
