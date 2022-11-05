class Post {
  String uid;
  String caption;
  List<String?> imageUrls;
  int likes;

  Post({
    required this.uid,
    required this.caption,
    required this.imageUrls,
    required this.likes,
  });

  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
      uid: data['uid'] ?? '',
      caption: data['caption'] ?? '',
      imageUrls: data['imagesUrls'] ?? [],
      likes: data['likes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'caption': caption,
      'imagesUrls': imageUrls,
      'likes': likes,
    };
  }
}
