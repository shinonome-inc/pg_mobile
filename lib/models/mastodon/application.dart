import 'package:freezed_annotation/freezed_annotation.dart';

part 'application.freezed.dart';
part 'application.g.dart';

@freezed
abstract class Application with _$Application {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Application({
    required String name,
    String? website,
    String? clientId,
    String? clientSecret,
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);
}
