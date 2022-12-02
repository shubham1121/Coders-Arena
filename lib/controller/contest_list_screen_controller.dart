import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/model/contest_list_model.dart';
import 'package:coders_arena/services/api/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ContestListScreenController with ChangeNotifier{
  ContestListStatus contestListStatus = ContestListStatus.nil;
  final ApiServices _apiServices = ApiServices();

  List<ContestListModel> contestList = [];

  Future<void> fetchContests() async
  { contestListStatus = ContestListStatus.fetching;
    List<ContestListModel> fetchedContestList = [];
    try{
      await Future.delayed(const Duration(milliseconds: 10));
      final Response? codechefResponse = await _apiServices.getContestList(clistApiEndUrl: '&host=codechef.com');
      final Response? codeforcesResponse = await _apiServices.getContestList(clistApiEndUrl: '&host=codeforces.com');
      final Response? hackerEarthResponse = await _apiServices.getContestList(clistApiEndUrl: '&host=hackerearth.com');
      final Response? leetcodeResponse = await _apiServices.getContestList(clistApiEndUrl: '&host=leetcode.com');

      if(codechefResponse!=null && codechefResponse.data!=null)
      {
        // List<dynamic> temp = codechefResponse.data["objects"];
        // debugPrint(temp.toString());
        for( var data in codechefResponse.data["objects"])
          {
            fetchedContestList.add(ContestListModel.fromJson(data));
          }
      }
      if(codeforcesResponse!=null && codeforcesResponse.data!=null)
      {
        // List<dynamic> temp = codeforcesResponse.data["objects"];
        // debugPrint(temp.toString());
        for( var data in codeforcesResponse.data["objects"])
        {
          fetchedContestList.add(ContestListModel.fromJson(data));
        }
        // debugPrint(codechefResponse.toString());
      }
      if(hackerEarthResponse!=null && hackerEarthResponse.data!=null)
      {
        // List<dynamic> temp = hackerEarthResponse.data["objects"];
        // debugPrint(temp.toString());
        for( var data in hackerEarthResponse.data["objects"])
        {
          fetchedContestList.add(ContestListModel.fromJson(data));
        }
        // debugPrint(codechefResponse.toString());
      }
      if(leetcodeResponse!=null && leetcodeResponse.data!=null)
      {
        // List<dynamic> temp = leetcodeResponse.data["objects"];
        // debugPrint(temp.toString());
        for( var data in leetcodeResponse.data["objects"])
        {
          fetchedContestList.add(ContestListModel.fromJson(data));
        }
        // debugPrint(codechefResponse.toString());
      }

    } catch (error){
      debugPrint(error.toString());
    }
    debugPrint(fetchedContestList[0].startTime.toString());
    contestList = fetchedContestList;
    contestListStatus = ContestListStatus.fetched;
    notifyListeners();
  }



}