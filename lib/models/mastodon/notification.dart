import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/relationship_severance_event.dart';
import 'package:pg_mobile/models/mastodon/report.dart';
import 'package:pg_mobile/models/mastodon/status.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notification with _$Notification {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Notification({
    required String id,
    required String type,
    required String createdAt,
    required Account account,
    Status status,
    Report? report,
    RelationshipSeveranceEvent? relationshipSeveranceEvent,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}
