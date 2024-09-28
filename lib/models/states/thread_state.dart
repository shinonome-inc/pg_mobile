import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/context.dart';

part 'thread_state.freezed.dart';

@freezed
class ThreadState with _$ThreadState {
  const factory ThreadState({
    required bool isLoading,
    required bool hasError,
    required Context context,
  }) = _ThreadState;
}

const ThreadState initialThreadState = ThreadState(
  isLoading: false,
  hasError: false,
  context: defaultContext,
);
