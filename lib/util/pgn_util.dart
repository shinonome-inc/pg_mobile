import 'package:pg_mobile/models/pgn_rank.dart';

class PGNUtil {
  PGNUtil._();

  static PGNRank spixToRank(int spix) {
    if (spix >= 35000) {
      return PGNRank.grandMaster;
    } else if (spix >= 20000) {
      return PGNRank.master;
    } else if (spix >= 10000) {
      return PGNRank.diamond;
    } else if (spix >= 5000) {
      return PGNRank.platinum;
    } else if (spix >= 2500) {
      return PGNRank.gold;
    } else if (spix >= 1000) {
      return PGNRank.silver;
    } else if (spix >= 500) {
      return PGNRank.bronze;
    } else if (spix >= 1) {
      return PGNRank.iron;
    } else if (spix == 0) {
      return PGNRank.dead;
    } else {
      throw ArgumentError('spix must be greater than or equal to 0');
    }
  }
}
