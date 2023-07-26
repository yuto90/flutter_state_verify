import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'count_provider.g.dart';

@riverpod
class CountNotifier extends _$CountNotifier {
  @override
  int build() {
    return 0;
  }

  void incrementCounter() {
    state++;
  }
}
