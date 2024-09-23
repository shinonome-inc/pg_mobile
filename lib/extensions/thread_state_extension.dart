import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/models/states/thread_state.dart';

extension ThreadStateExtension on ThreadState {
  List<Status> get ancestors => context.ancestors;
  List<Status> get descendants => context.descendants;
}
