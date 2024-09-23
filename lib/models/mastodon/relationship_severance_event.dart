import 'package:freezed_annotation/freezed_annotation.dart';

part 'relationship_severance_event.freezed.dart';
part 'relationship_severance_event.g.dart';

@freezed
class RelationshipSeveranceEvent with _$RelationshipSeveranceEvent {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RelationshipSeveranceEvent({
    required String id,
    required String type,
    required bool purged,
    required String targetName,
    int? relationshipsCount,
    required String createdAt,
  }) = _RelationshipSeveranceEvent;

  factory RelationshipSeveranceEvent.fromJson(Map<String, dynamic> json) =>
      _$RelationshipSeveranceEventFromJson(json);
}
