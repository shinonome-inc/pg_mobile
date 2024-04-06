import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_hash.freezed.dart';
part 'application_hash.g.dart';

@freezed
class ApplicationHash with _$ApplicationHash {
  const factory ApplicationHash({
    required String name,
    String? website,
  }) = _ApplicationHash;
  factory ApplicationHash.fromJson(Map<String, dynamic> json) =>
      _$ApplicationHashFromJson(json);
}
