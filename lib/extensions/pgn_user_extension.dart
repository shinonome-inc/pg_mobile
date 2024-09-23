import 'package:pg_mobile/models/enums/pgn_rank.dart';
import 'package:pg_mobile/models/pgn/pgn_user.dart';
import 'package:pg_mobile/util/pgn_util.dart';

extension PGNUserExtension on PGNUser {
  PGNRank get _rank => PGNUtil.spixToRank(total);

  String get rankImagePath => _rank.imagePath;
  String get rankText => _rank.text;
}
