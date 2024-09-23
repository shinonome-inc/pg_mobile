import 'package:freezed_annotation/freezed_annotation.dart';

part 'office_log.freezed.dart';
part 'office_log.g.dart';

@freezed
class OfficeLog with _$OfficeLog {
  const factory OfficeLog({
    required String id,
    required String officeId,
    required String userId,
    required String checkInDate,
    required String checkOutDate,
  }) = _OfficeLog;

  factory OfficeLog.fromJson(Map<String, Object?> json) =>
      _$OfficeLogFromJson(json);
}

const OfficeLog defaultOfficeLog = OfficeLog(
  id: '',
  officeId: '',
  userId: '',
  checkInDate: '',
  checkOutDate: '',
);
