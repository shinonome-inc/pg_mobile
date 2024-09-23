import 'package:freezed_annotation/freezed_annotation.dart';

part 'office_user.freezed.dart';
part 'office_user.g.dart';

@freezed
class OfficeUser with _$OfficeUser {
  const factory OfficeUser({
    required String id,
    required String name,
    required String imageUrl,
  }) = _OfficeUser;

  factory OfficeUser.fromJson(Map<String, Object?> json) =>
      _$OfficeUserFromJson(json);
}

const OfficeUser defaultOfficeUser = OfficeUser(
  id: '',
  name: '',
  imageUrl: '',
);

const OfficeUser signInUser = OfficeUser(
  id: 'signInUser',
  name: 'サインイン中のユーザー',
  imageUrl: '',
);
