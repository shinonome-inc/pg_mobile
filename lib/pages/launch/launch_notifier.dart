import 'package:pg_mobile/pages/launch/launch_state.dart';
import 'package:pg_mobile/repository/secure_storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'launch_notifier.g.dart';

@riverpod
class LaunchNotifier extends _$LaunchNotifier {
  @override
  LaunchState build() {
    return initialLaunchState;
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  Future<bool> isSignedIn() async {
    final token = await SecureStorageRepository.readToken();
    final isSignedIn = token != null && token.isNotEmpty;
    return isSignedIn;
  }
}
