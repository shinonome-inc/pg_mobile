import 'package:freezed_annotation/freezed_annotation.dart';

part 'pgn_user.freezed.dart';
part 'pgn_user.g.dart';

@freezed
class PGNUser with _$PGNUser {
  const factory PGNUser({
    @JsonKey(defaultValue: '') required String id,
    @JsonKey(defaultValue: '') required String slackId,
    @JsonKey(defaultValue: 0) required int total,
    @JsonKey(name: 'total_pgrit', defaultValue: 0) required int totalPgrit,
    @JsonKey(name: 'total_dawn', defaultValue: 0) required int totalDawn,
    @JsonKey(name: 'totao_other', defaultValue: 0) required int totalOther,
  }) = _PGNUser;

  factory PGNUser.fromJson(Map<String, Object?> json) =>
      _$PGNUserFromJson(json);
}

const PGNUser defaultPGNUser = PGNUser(
  id: '',
  slackId: '',
  total: 0,
  totalPgrit: 0,
  totalDawn: 0,
  totalOther: 0,
);
