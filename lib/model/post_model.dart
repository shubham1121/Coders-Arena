class PostModel {
  String uid;
  String caption;
  List<dynamic> imageUrls;
  int likes;
  String postId;
  String postsCreated;

  PostModel({
    required this.uid,
    required this.caption,
    required this.imageUrls,
    required this.likes,
    required this.postId,
    required this.postsCreated,
  });

  factory PostModel.fromJson(Map<String, dynamic> data) {
    return PostModel(
      uid: data['uid'] ?? '',
      caption: data['caption'] ?? '',
      imageUrls: data['imagesUrls'] ?? [],
      likes: data['likes'] ?? 0,
      postId : data['postId'] ?? '',
      postsCreated : data['postsCreated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'caption': caption,
      'imagesUrls': imageUrls,
      'likes': likes,
      'postId':postId,
      'postsCreated': postsCreated,
    };
  }
}
