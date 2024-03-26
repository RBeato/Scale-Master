import 'package:flutter_riverpod/flutter_riverpod.dart';

final chordExtensionsProvider =
    StateNotifierProvider<SelectedChordExtensions, List<String>>(
  (ref) => SelectedChordExtensions(),
);

class SelectedChordExtensions extends StateNotifier<List<String>> {
  SelectedChordExtensions() : super([]);

  List<String> get selectedItemsList => state;

  void addExtension(String text) {
    // print(state);
    state = List.of(state)..add(text);
  }

  void removeExtension(String text) {
    state = state.where((element) => false).toList();
  }
}
