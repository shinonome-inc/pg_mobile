import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_option.freezed.dart';
part 'poll_option.g.dart';

@freezed
abstract class PollOption with _$PollOption {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PollOption({
    required String title,
    int? votesCount,
  }) = _PollOption;

  factory PollOption.fromJson(Map<String, dynamic> json) =>
      _$PollOptionFromJson(json);
}
