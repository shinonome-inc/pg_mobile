import 'package:freezed_annotation/freezed_annotation.dart';

part 'follower_model.freezed.dart';
part 'follower_model.g.dart';

@freezed
class FollowerModel with _$FollowerModel {
  const factory FollowerModel({
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'avatar') required String avatarUrl,
  }) = _FollowerModel;

  factory FollowerModel.fromJson(Map<String, dynamic> json) =>
      _$FollowerModelFromJson(json);
}
