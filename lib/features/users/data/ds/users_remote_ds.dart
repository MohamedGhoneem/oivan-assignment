import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:network_implementation/network_implementation.dart';
import 'package:oivan_assignment/features/users/data/model/get_users_model.dart';
import 'package:oivan_assignment/utilities/constants.dart';
import '../model/get_reputation_model.dart';
import '../model/request_model.dart';

class UsersRemoteDataSource {
  final NetworkImplementation _networkClient;

  UsersRemoteDataSource(this._networkClient);

  Future<GetUsersModel> getUsers(RequestModel params) async {
    try {
      final response = await _networkClient.request(HttpMethod.get,
          endpoint: usersEndPoint,
          queryParameters: params.toJson(),
          headers: {
            'Accept': 'application/json;charset=utf-t',
            'Accept-Language': 'en',
          });
      log('getUsers response : $response');

      return GetUsersModel.fromJson(response?.data);
    } catch (e) {
      debugPrint('getUsers errorrrrrrrr');

      throw Exception('Failed to load users');
    }
  }

  Future<GetReputationModel> getUserReputation(
      RequestModel params, int userId) async {
    try {
      final response = await _networkClient.request(
        HttpMethod.get,
        endpoint: '$usersEndPoint/$userId$reputationsEndPoint',
        queryParameters: params.toJson(),
      );
      log('getUserReputation response : $response');

      return GetReputationModel.fromJson(response?.data);
    } catch (e) {
      debugPrint('getUserReputation errorrrrrrrr');

      throw Exception('Failed to load users');
    }
  }
}
