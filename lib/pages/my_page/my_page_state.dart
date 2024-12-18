import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/status.dart';

part 'my_page_state.freezed.dart';

@freezed
class MyPageState with _$MyPageState {
  const factory MyPageState({
    required bool isLoading,
    required List<Status> statusesWithoutReply,
    required List<Status> statusesWithReply,
    required List<Status> mediaStatuses,
  }) = _MyPageState;
}

const MyPageState initialMyPageState = MyPageState(
  isLoading: false,
  statusesWithoutReply: [],
  statusesWithReply: [],
  mediaStatuses: [],
);
