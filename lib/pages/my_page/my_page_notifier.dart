import 'package:pg_mobile/pages/my_page/my_page_state.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_page_notifier.g.dart';

@riverpod
class MyPageNotifier extends _$MyPageNotifier {
  @override
  MyPageState build() {
    return initialMyPageState;
  }

  void _setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  Future<void> fetchStatuses() async {
    if (state.isLoading) return;
    final accountId = ref.read(signedInUserNotifierProvider)?.id;
    if (accountId == null) return;
    _setLoading(true);
    try {
      final statuses = await MastodonRepository.instance.fetchAccountStatuses(
        accountId,
        excludeReplies: true,
      );
      state = state.copyWith(statuses: statuses);
    } catch (e) {
      throw Exception('Failed to fetch statuses: $e');
    } finally {
      _setLoading(false);
    }
  }
}
