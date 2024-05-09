import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/pgn_rank.dart';
import 'package:pg_mobile/util/pgn_util.dart';

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

extension PGNUserExtension on PGNUser {
  PGNRank get _rank => PGNUtil.spixToRank(total);

  String get rankImagePath => _rank.imagePath;
  String get rankText => _rank.text;
}
