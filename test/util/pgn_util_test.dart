import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/models/pgn_rank.dart';
import 'package:pg_mobile/util/pgn_util.dart';

void main() {
  group('PGNUtil', () {
    group('spixToRank', () {
      test('35000SPIXがGrandMasterになるか', () {
        expect(PGNUtil.spixToRank(35000), equals(PGNRank.grandMaster));
      });

      test('34999SPIXがMasterになるか', () {
        expect(PGNUtil.spixToRank(34999), equals(PGNRank.master));
      });

      test('20000SPIXがMasterになるか', () {
        expect(PGNUtil.spixToRank(20000), equals(PGNRank.master));
      });

      test('19999SPIXがDiamondになるか', () {
        expect(PGNUtil.spixToRank(19999), equals(PGNRank.diamond));
      });

      test('10000SPIXがDiamondになるか', () {
        expect(PGNUtil.spixToRank(10000), equals(PGNRank.diamond));
      });

      test('9999SPIXがPlatinumになるか', () {
        expect(PGNUtil.spixToRank(9999), equals(PGNRank.platinum));
      });

      test('5000SPIXがPlatinumになるか', () {
        expect(PGNUtil.spixToRank(5000), equals(PGNRank.platinum));
      });

      test('4999SPIXがGoldになるか', () {
        expect(PGNUtil.spixToRank(4999), equals(PGNRank.gold));
      });

      test('2500SPIXがGoldになるか', () {
        expect(PGNUtil.spixToRank(2500), equals(PGNRank.gold));
      });

      test('2499SPIXがSilverになるか', () {
        expect(PGNUtil.spixToRank(2499), equals(PGNRank.silver));
      });

      test('1000SPIXがSilverになるか', () {
        expect(PGNUtil.spixToRank(1000), equals(PGNRank.silver));
      });

      test('999SPIXがBronzeになるか', () {
        expect(PGNUtil.spixToRank(999), equals(PGNRank.bronze));
      });

      test('500SPIXがBronzeになるか', () {
        expect(PGNUtil.spixToRank(500), equals(PGNRank.bronze));
      });

      test('499SPIXがIronになるか', () {
        expect(PGNUtil.spixToRank(499), equals(PGNRank.iron));
      });

      test('1SPIXがIronになるか', () {
        expect(PGNUtil.spixToRank(1), equals(PGNRank.iron));
      });

      test('0SPIXがDeadになるか', () {
        expect(PGNUtil.spixToRank(0), equals(PGNRank.dead));
      });

      test('負の値が与えられた場合は例外をスローするか', () {
        expect(() => PGNUtil.spixToRank(-1), throwsArgumentError);
      });
    });
  });
}
