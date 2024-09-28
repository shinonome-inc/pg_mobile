import 'package:pg_mobile/models/mastodon/context.dart';
import 'package:pg_mobile/models/states/thread_state.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'thread_notifier.g.dart';

@riverpod
class ThreadNotifier extends _$ThreadNotifier {
  @override
  ThreadState build() {
    return initialThreadState;
  }

  void _reset() {
    state = initialThreadState;
  }

  void _setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void _setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  Future<void> fetchThreadStatuses(String id) async {
    if (state.isLoading) return;
    Context context;
    _setLoading(true);
    _setError(false);
    try {
      context = await MastodonRepository.instance.fetchThread(id);
    } catch (e) {
      _setError(true);
      throw Exception('Failed to fetch thread statuses: $e');
    } finally {
      _setLoading(false);
    }
    state = state.copyWith(context: context);
  }

  Future<void> reload(String id) async {
    _reset();
    await fetchThreadStatuses(id);
  }
}
