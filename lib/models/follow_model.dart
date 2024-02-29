class FollowModel {
  final String displayName;
  final String username;
  final String avatarUrl;
  FollowModel({
    required this.displayName,
    required this.username,
    required this.avatarUrl,
  });
  factory FollowModel.fromJson(Map<String, dynamic> json) {
    return FollowModel(
      displayName: json['display_name'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar'] as String,
    );
  }
}
