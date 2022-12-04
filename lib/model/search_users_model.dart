class LowDetailUser {
  final String name;
  final String dp;
  final String userId;

  LowDetailUser({
    required this.name,
    required this.dp,
    required this.userId,
  });

  factory LowDetailUser.fromJson(Map<String, dynamic> json) => LowDetailUser(
    dp: json["dp"],
    name: json["name"],
    userId: json["userId"],
  );

}
