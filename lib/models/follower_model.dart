class FollowerModel {
  final String displayName;
  final String username;
  final String avatarUrl;
  FollowerModel({
    required this.displayName,
    required this.username,
    required this.avatarUrl,
  });
  factory FollowerModel.fromJson(Map<String, dynamic> json) {
    return FollowerModel(
      displayName: json['display_name'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar'] as String,
    );
  }
}
