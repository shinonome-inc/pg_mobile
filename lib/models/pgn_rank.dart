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
