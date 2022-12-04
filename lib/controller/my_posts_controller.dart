import 'package:coders_arena/controller/disposable_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/model/post_model.dart';
import 'package:coders_arena/services/api/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyPostsController extends DisposableProvider {
  PostUploadingStatus postUploadingStatus = PostUploadingStatus.notUploading;
  List<PostModel> myPublishedPosts = [];
  FetchingMyPosts fetchingMyPosts = FetchingMyPosts.nil;
  final ApiServices _apiServices = ApiServices();

  fetchMyPosts(String myUid) async {
    fetchingMyPosts = FetchingMyPosts.fetching;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
    try {
      List<PostModel> tempPublished = [];
      final Response? response =
      await _apiServices.get(apiEndUrl: 'posts/$myUid.json');
      if (response != null) {
        final Map<String, dynamic> responseData = response.data;
        for (var post in responseData.values) {
          PostModel postModel = PostModel.fromJson(post);
          tempPublished.add(postModel);
        }
        myPublishedPosts = tempPublished;
      }
    } catch (error) {
     debugPrint(error.toString());
    }
    fetchingMyPosts = FetchingMyPosts.fetched;
    notifyListeners();
  }

  Future<void> deleteThisArticle(
      {required String myUid, required String postId}) async {
    try {
      // fetchingMyPosts = FetchingMyPosts.fetching;
      // notifyListeners();
      final Response? response =
      await _apiServices.delete(apiEndUrl: 'posts/$myUid/$postId.json');
      if (response != null) {
        myPublishedPosts
            .removeWhere((element) => element.postId== postId);
      }
    } catch (error) {
      // logger.shout(error.toString());
      debugPrint(error.toString());
    }
    // fetchingMyPosts = FetchingMyPosts.fetched;
    notifyListeners();
  }

  @override
  void disposeValues() {
    postUploadingStatus = PostUploadingStatus.notUploading;
    myPublishedPosts = [];
    fetchingMyPosts = FetchingMyPosts.nil;
  }
}
