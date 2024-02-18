import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/models/chord_model.dart';

import 'beat_counter_provider.dart';

final selectedChordsProvider =
    StateNotifierProvider<SelectedChords, List<ChordModel>>(
  (ref) => SelectedChords(ref),
);

class SelectedChords extends StateNotifier<List<ChordModel>> {
  SelectedChords(this.ref, [List<ChordModel>? selectedItems])
      : super(selectedItems ?? []);

  final StateNotifierProviderRef ref;

  List<ChordModel> get selectedItemsList => state;

  void addChord(ChordModel chordModel) {
    state = List.of(state)..add(chordModel);

    int sum =
        state.fold(0, (previousValue, item) => previousValue + item.duration);

    ref.read(beatCounterProvider.notifier).setNumberOfBeats(sum);
  }

  void removeAll() {
    state = [];
  }
}
