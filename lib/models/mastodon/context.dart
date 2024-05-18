import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/status.dart';

part 'context.freezed.dart';
part 'context.g.dart';

@freezed
class Context with _$Context {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Context({
    required List<Status> ancestors,
    required List<Status> descendants,
  }) = _Context;

  factory Context.fromJson(Map<String, dynamic> json) =>
      _$ContextFromJson(json);
}

const Context defaultContext = Context(
  ancestors: [],
  descendants: [],
);
