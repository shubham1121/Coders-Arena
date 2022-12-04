import 'package:coders_arena/controller/disposable_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/model/search_users_model.dart';
import 'package:coders_arena/services/api/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllUsers extends DisposableProvider {
  final ApiServices _apiServices = ApiServices();
  FetchingAllUsers fetchingAllUsers = FetchingAllUsers.nil;
  Map<String, LowDetailUser> allUsers = {};

  fetchAllUsers() async {
    Map<String, LowDetailUser> allUsersTemp = {};
    fetchingAllUsers = FetchingAllUsers.fetching;
    notifyListeners();
    try {
      final Response? response =
          await _apiServices.get(apiEndUrl: 'users.json');
      if (response != null) {
        Map<String, dynamic> temp = response.data;
        for (String uid in temp.keys) {
          LowDetailUser lowDetailUser = LowDetailUser.fromJson(temp[uid]);
          allUsersTemp[uid] = lowDetailUser;
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    allUsers = allUsersTemp;
    fetchingAllUsers = FetchingAllUsers.fetched;
    notifyListeners();
  }

  @override
  void disposeValues() {
    fetchingAllUsers = FetchingAllUsers.nil;
    allUsers = {};
  }
}
