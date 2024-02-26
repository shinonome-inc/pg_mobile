import 'package:freezed_annotation/freezed_annotation.dart';

part 'follower_model.freezed.dart';
part 'follower_model.g.dart';

@freezed
class FollowerModel with _$FollowerModel {
  const factory FollowerModel({
    required String display_name,
    required String username,
    required String avatar,
  }) = _FollowerModel;

  factory FollowerModel.fromJson(Map<String, dynamic> json) =>
      _$FollowerModelFromJson(json);
}
