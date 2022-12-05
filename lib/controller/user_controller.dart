import 'dart:io';
import 'package:coders_arena/controller/disposable_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/model/search_users_model.dart';
import 'package:coders_arena/model/user_model.dart';
import 'package:coders_arena/services/api/api_services.dart';
import 'package:coders_arena/services/firebase_services/firebase_storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;


class UserController extends DisposableProvider {
  final ApiServices _apiServices = ApiServices();
  final ImagePicker _imagePicker = ImagePicker();

  ProfileStatus profileStatus = ProfileStatus.nil;
  UserUploadingImage userUploadingImage = UserUploadingImage.notLoading;
  FollowingUserStatus followingUserStatus = FollowingUserStatus.no;
  FetchingMyFollowersAndFollowings fetchingMyFollowersAndFollowings = FetchingMyFollowersAndFollowings.nil;
  FetchingAllUsers fetchingAllUsers = FetchingAllUsers.nil;
  Map<String, LowDetailUser> allUsers = {};
  UserModel? user;
  List<UserModel> myFollowers = [];
  List<UserModel> myFollowing = [];
  List<LowDetailUser> queryRes = [];
  // set current user
  setUser(String userId) async {
    profileStatus = ProfileStatus.loading;
    final endUrl = 'users/$userId.json';
    try {
      final Response? response = await _apiServices.get(apiEndUrl: endUrl);
      if (response != null) {
        fetchAllUsers();
        user = UserModel.fromJson(response.data);
        fetchFollowersAndFollowing(user!.followers, user!.following);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    profileStatus = ProfileStatus.fetched;
    notifyListeners();
  }

  searchUser(String prefName)
  { List<LowDetailUser> temp = [];
    if(prefName.isEmpty)
      {
        queryRes = temp;
        notifyListeners();
        return;
      }
    for(String uid in allUsers.keys)
      { if(allUsers[uid]!.name.startsWith(prefName))
        {
          temp.add(allUsers[uid]!);
        }
      }
    queryRes = temp;
    notifyListeners();
  }

  // call this method and provide an user object to create a new user
  createUser(UserModel newUser) async {
    try {
      final Response? response = await _apiServices.put(
          apiEndUrl: 'users/${newUser.userId}.json', data: newUser.toJson());
      if (response != null) {
        debugPrint("user created successfully");
        user = newUser;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    profileStatus = ProfileStatus.fetched;
    notifyListeners();
  }

  // This method returns an User object.

  Future<UserModel?> getUser(String uid) async {
    try {
      final response = await _apiServices.get(apiEndUrl: 'users/$uid.json');
      if (response != null) {
        return UserModel.fromJson(response.data);
      }
    } catch (error) {
      return null;
    }
    return null;
  }

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

   fetchFollowersAndFollowing(List<dynamic> followers, List<dynamic>followings) async{
    List<UserModel> followersList= [];
    List<UserModel> followingList= [];
    try{
      debugPrint('fetching followers');
      fetchingMyFollowersAndFollowings = FetchingMyFollowersAndFollowings.fetching;
      notifyListeners();
      for( var uid in followers)
        {
          final response = await _apiServices.get(apiEndUrl: 'users/$uid.json');
          if(response!=null)
            {
              followersList.add(UserModel.fromJson(response.data));
            }
        }
      for( var uid in followings)
      {
        final response = await _apiServices.get(apiEndUrl: 'users/$uid.json');
        if(response!=null)
        {
          followingList.add(UserModel.fromJson(response.data));
        }
      }
    } catch (error)
    {
      debugPrint(error.toString());
    }
    myFollowers = followersList;
    myFollowing = followingList;
    debugPrint(myFollowers.toString());
    debugPrint(myFollowing.toString());
    fetchingMyFollowersAndFollowings = FetchingMyFollowersAndFollowings.fetched;
    notifyListeners();
  }

  Future chooseImage() async {
    XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
      final file = File(pickedImage!.path);
      CroppedFile? croppedFile = await cropSquareImage(file);
      if (croppedFile != null) {
        debugPrint(croppedFile.path);
        File tempFile = File(croppedFile.path);
        changeDisplayPhoto(tempFile);
      } else {
       debugPrint('Null Cropped File');
      }
    notifyListeners();
  }

  Future<CroppedFile?> cropSquareImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      cropStyle: CropStyle.circle,
      compressQuality: 50,
      uiSettings: [
        androidUiSettingsLocked(),
      ],
    );
    return croppedFile;
  }

  AndroidUiSettings androidUiSettingsLocked() {
    return AndroidUiSettings(
      toolbarColor: Colors.indigo,
      toolbarWidgetColor: Colors.white,
    );
  }


  // Change display picture , user needs to pass an XFile
  void changeDisplayPhoto(File imageFile) async {
    try {
      debugPrint('Called here');
      userUploadingImage = UserUploadingImage.loading;
      // await Future.delayed(const Duration(milliseconds: 100));
      notifyListeners();
      String? url = await getImageUrl(
          File(imageFile.path), 'users/${user!.userId}/displayPhoto/${path.basename(imageFile.path)}');
      await _apiServices
          .update(apiEndUrl: 'users/${user!.userId}.json', data: {'dp': url!});
      user!.updateUserDisplayPicture(url);
    } catch (error) {
      return null;
    }
    userUploadingImage = UserUploadingImage.notLoading;
    notifyListeners();
  }

  // By calling this method currently signed in user can follow the user with the passed userd id.
  void followUser({required userId}) async {
    followingUserStatus = FollowingUserStatus.yes;
    // profileStatus = ProfileStatus.loading;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
    try {
      UserModel? userToFollow = await getUser(userId); // get user by user id
      if (userToFollow != null) {
        List<dynamic> followers =
            userToFollow.followers; // get their followers.
        followers.add(user!.userId); // increase their followers locally.
        // update their profile to the server.
        await _apiServices.update(
            apiEndUrl: 'users/$userId.json', data: {'followers': followers});
        // update currently signed in user's profile (increase following list first)
        List<dynamic> myFollowings = user!.following;
        // increase my following locally.
        myFollowings.add(userId);
        // update following list to my profile (server)
        await _apiServices.update(
            apiEndUrl: 'users/${user!.userId}.json',
            data: {'following': myFollowings});
        user!.following = myFollowings;
        // notifyUserWhenFollowedUser(user!.userId, userId);
      }
    } catch (error) {
      // logger.shout(error.toString());
    }

    followingUserStatus = FollowingUserStatus.no;
    // profileStatus = ProfileStatus.fetched;
    notifyListeners();
  }
  //
  // // By calling this method currently signed in user can unfollow the user with the passed user id.
  void unFollowUser({required userId}) async {
    // Logger logger = Logger("FollowAuthor");
    followingUserStatus = FollowingUserStatus.yes;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
    try {
      UserModel? userToFollow = await getUser(userId); // get user by user id
      if (userToFollow != null) {
        List<dynamic> followers =
            userToFollow.followers; // get their followers.
        followers.remove(user!.userId); // increase their followers locally.
        // update their profile to the server.
        await _apiServices.update(
            apiEndUrl: 'users/$userId.json', data: {'followers': followers});
        // update currently signed in user's profile (increase following list first)
        List<dynamic> myFollowings = user!.following;
        // increase my following locally.
        myFollowings.remove(userId);
        // update following list to my profile (server)
        await _apiServices.update(
            apiEndUrl: 'users/${user!.userId}.json',
            data: {'following': myFollowings});
        user!.following = myFollowings;
      }
    } catch (error) {
      // logger.shout(error.toString());
    }
    followingUserStatus = FollowingUserStatus.no;
    notifyListeners();
  }

  // Update profile -> username, about, birthday
  updateProfile({required String name, required String about, required String birthday}) async {
    try {
      profileStatus = ProfileStatus.loading;
      final Response? profileUpdateResponse = await _apiServices
          .update(apiEndUrl: 'users/${user!.userId}.json', data: {
        'name': name,
        'about': about,
        'birthday':birthday
      });
      if (profileUpdateResponse != null) {
        user!.updateUserProfileData(name, about,birthday);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    profileStatus = ProfileStatus.fetched;
    notifyListeners();
  }



  // Saves article id and article author id to the list
  // saveArticle({required String authorId, required String articleId}) async {
  //   dynamic savedArticle = {'authorId': authorId, 'articleId': articleId};
  //   List<dynamic> savedArticleList = user!.savedArticles;
  //   savedArticleList.add(savedArticle);
  //   try {
  //     final Response? response = await _apiServices.update(
  //         endUrl: 'users/${user!.userId}.json',
  //         data: {'savedArticles': savedArticleList});
  //     if (response != null) {
  //       user!.updateSavedArticleList(savedArticleList);
  //     }
  //   } catch (error) {
  //     logger.shout(error.toString());
  //   }
  //   notifyListeners();
  // }

  // Unsave the article
  // unSaveArticle({required String authorId, required String articleId}) async {
  //   Logger logger = Logger("unSaveArticle");
  //
  //   List<dynamic> savedArticleList = user!.savedArticles;
  //   int indexTobeRemoved = savedArticleList.indexWhere((element) =>
  //   (element['articleId'] == articleId && element['authorId'] == authorId));
  //
  //   savedArticleList.removeAt(indexTobeRemoved);
  //   try {
  //     final Response? response = await _apiServices.update(
  //         endUrl: 'users/${user!.userId}.json',
  //         data: {'savedArticles': savedArticleList});
  //     if (response != null) {
  //       user!.updateSavedArticleList(savedArticleList);
  //     }
  //   } catch (error) {
  //     logger.shout(error.toString());
  //   }
  //   notifyListeners();
  // }
  @override
  void disposeValues() {
    profileStatus = ProfileStatus.nil;
    userUploadingImage = UserUploadingImage.notLoading;
    followingUserStatus = FollowingUserStatus.no;
    fetchingMyFollowersAndFollowings = FetchingMyFollowersAndFollowings.nil;
    fetchingAllUsers = FetchingAllUsers.nil;
    allUsers = {};
    myFollowers = [];
    myFollowing = [];
    user = null;
  }

}
