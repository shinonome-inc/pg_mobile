import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/status.dart';

part 'my_page_state.freezed.dart';

@freezed
class MyPageState with _$MyPageState {
  const factory MyPageState({
    required bool isLoading,
    required List<Status> statuses,
  }) = _MyPageState;
}

const MyPageState initialMyPageState = MyPageState(
  isLoading: false,
  statuses: [],
);
