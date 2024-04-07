import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/custom_emoji.dart';
import 'package:pg_mobile/models/mastodon/poll_option.dart';

part 'poll.freezed.dart';
part 'poll.g.dart';

@freezed
abstract class Poll with _$Poll {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Poll({
    required String id,
    required String? expiresAt,
    required bool expired,
    required bool multiple,
    required int votesCount,
    int? votersCount,
    required List<PollOption> options,
    required List<CustomEmoji> emojis,
    bool? voted,
    List<int>? ownVotes,
  }) = _Poll;

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);
}
