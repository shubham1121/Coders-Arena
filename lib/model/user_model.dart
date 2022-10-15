class User {
  String name;
  String userId;
  String email;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> intrests;
  List<dynamic> myPosts;
  String dp;
  String about;
  String birthday;

  User({
    required this.name,
    required this.dp,
    required this.email,
    required this.followers,
    required this.following,
    required this.intrests,
    required this.myPosts,
    required this.userId,
    required this.about,
    required this.birthday,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      name: data['name'] ?? '',
      about: data['about'] ?? '',
      dp: data['dp'],
      email: data['email'],
      followers: data['followers'] ?? [],
      intrests: data['intrests'] ?? [],
      userId: data['userId'],
      following: data['following'] ?? [],
      myPosts: data['myPosts'] ?? [],
      birthday: data['birthday'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'dp': dp,
      'about': about,
      'userId': userId,
      'followers': followers,
      'following': following,
      'myPosts': myPosts,
      'birthday': birthday,
      'intrests': intrests,
    };
  }

  updateUserDisplayPicture(String displayPicture) {
    dp = displayPicture;
  }

  updateUserProfileData(String updatedName, String updatedAbout) {
    name = updatedName;
    about = updatedAbout;
  }
}
