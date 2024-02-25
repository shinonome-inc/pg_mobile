import 'package:freezed_annotation/freezed_annotation.dart';

part 'office.freezed.dart';
part 'office.g.dart';

@freezed
class Office with _$Office {
  const factory Office({
    required String id,
    required String name,
    required String imageUrl,
    required double minLatitude,
    required double maxLatitude,
    required double minLongitude,
    required double maxLongitude,
    required List<String> userIdList,
  }) = _Office;

  factory Office.fromJson(Map<String, Object?> json) => _$OfficeFromJson(json);
}

const Office defaultOffice = Office(
  id: '',
  name: '',
  imageUrl: '',
  minLatitude: 0.0,
  maxLatitude: 0.0,
  minLongitude: 0.0,
  maxLongitude: 0.0,
  userIdList: [],
);
