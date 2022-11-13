import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/model/post_model.dart';
import 'package:coders_arena/services/api/api_services.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedScreenController with ChangeNotifier {
  final ApiServices _apiServices = ApiServices();
  PostsStatus postsStatus = PostsStatus.nil;
  String? myUid = FirebaseAuth.instance.currentUser!.uid;

  Map<String, List<PostModel>> feedScreenPosts = {};

  Future<void> fetchPosts() async {
    debugPrint('called here but why');
    Map<String, List<PostModel>> fetchedPost = {};
    try {
      postsStatus = PostsStatus.fetching;
      //Assign the value only if it is null.
      myUid ??= FirebaseAuth.instance.currentUser!.uid;
      await Future.delayed(const Duration(microseconds: 5));

      final Response? otherUserResponse =
          await _apiServices.get(apiEndUrl: 'posts/.json');
      // debugPrint(otherUserResponse!.data.toString());
      if (otherUserResponse != null && otherUserResponse.data != null) {
        Map<String, dynamic> postByOtherUsers = otherUserResponse.data;
        // debugPrint(postByOtherUsers.keys.toString());
        for (String userId in postByOtherUsers.keys) {
          debugPrint(userId.toString());
          // debugPrint(postByOtherUsers[uid].toString());
          Map<String, dynamic> mapPosts = postByOtherUsers[userId];
          // debugPrint(mapPosts.length.toString());
          for (var postId in mapPosts.keys) {
            PostModel postModel = PostModel.fromJson(mapPosts[postId]);
            if (fetchedPost[userId] == null) {
              List<PostModel> tempList = [];
              tempList.add(postModel);
              fetchedPost[userId] = tempList;
            } else {
              fetchedPost[userId]!.add(postModel);
            }
          }
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    debugPrint(fetchedPost.toString());
    feedScreenPosts = fetchedPost;
    postsStatus = PostsStatus.fetched;
    notifyListeners();
  }

  // @override
  // void disposeValues() {
  //   // TODO: implement disposeValues
  //   feedScreenPosts = {};
  //   myUid = null;
  //   // searchedAuthors = [];
  //   postsStatus = PostsStatus.nil;
  //   // searchedArticles = [];
  // }
}
