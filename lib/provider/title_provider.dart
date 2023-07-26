import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'title_provider.g.dart';

@riverpod
class TitleNotifier extends _$TitleNotifier {
  @override
  String build() {
    return "riverpodの実験";
  }

  void changeTitle(String new_title) {
    state = new_title;
  }
}
