import 'package:freezed_annotation/freezed_annotation.dart';

part 'relationship.freezed.dart';
part 'relationship.g.dart';

@freezed

/// Relationshipのモデルクラス。
///
/// Relationshipは、フォローやミュート、ブロックなどのアカウント間の関係を表す。
class Relationship with _$Relationship {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Relationship({
    required String id,
    required bool following,
    required bool showingReblogs,
    required bool notifying,
    List<String>? languages,
    required bool followedBy,
    required bool blocking,
    required bool blockedBy,
    required bool muting,
    required bool mutingNotifications,
    required bool requested,
    required bool? requestedBy,
    required bool domainBlocking,
    required bool endorsed,
    required String note,
  }) = _Relationship;

  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
}
