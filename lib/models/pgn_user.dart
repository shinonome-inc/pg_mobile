import 'package:freezed_annotation/freezed_annotation.dart';

part 'pgn_user.freezed.dart';
part 'pgn_user.g.dart';

@freezed
class PGNUser with _$PGNUser {
  const factory PGNUser({
    required String userId,
    required int total,
    required int totalPgrit,
    required int totalDawn,
    required int totalOther,
  }) = _PGNUser;

  factory PGNUser.fromJson(Map<String, Object?> json) =>
      _$PGNUserFromJson(json);
}

const PGNUser defaultPGNUser = PGNUser(
  userId: '',
  total: 0,
  totalPgrit: 0,
  totalDawn: 0,
  totalOther: 0,
);
