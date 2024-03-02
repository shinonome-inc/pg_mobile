import 'package:pg_mobile/constants/image_paths.dart';

enum PGNRank {
  dead,
  iron,
  bronze,
  silver,
  gold,
  platinum,
  diamond,
  master,
  grandMaster;

  String get text {
    switch (this) {
      case PGNRank.dead:
        return 'Dead';
      case PGNRank.iron:
        return 'Iron';
      case PGNRank.bronze:
        return 'Bronze';
      case PGNRank.silver:
        return 'Silver';
      case PGNRank.gold:
        return 'Gold';
      case PGNRank.platinum:
        return 'Platinum';
      case PGNRank.diamond:
        return 'Diamond';
      case PGNRank.master:
        return 'Master';
      case PGNRank.grandMaster:
        return 'GrandMaster';
    }
  }

  String get imagePath {
    switch (this) {
      // TODO: 画像を入手したら差し替える。
      case PGNRank.dead:
        return '';
      case PGNRank.iron:
        return ImagePaths.pgnIron;
      case PGNRank.bronze:
        return ImagePaths.pgnBronze;
      case PGNRank.silver:
        return ImagePaths.pgnSilver;
      case PGNRank.gold:
        return ImagePaths.pgnGold;
      case PGNRank.platinum:
        return ImagePaths.pgnPlatinum;
      case PGNRank.diamond:
        return ImagePaths.pgnDiamond;
      case PGNRank.master:
        return ImagePaths.pgnMaster;
      case PGNRank.grandMaster:
        return ImagePaths.pgnGrandMaster;
    }
  }
}

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
