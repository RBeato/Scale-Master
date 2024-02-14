import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/models/chord_model.dart';

final selectedChordsProvider =
    StateNotifierProvider<SelectedChords, List<ChordModel>>(
  (ref) => SelectedChords(),
);

class SelectedChords extends StateNotifier<List<ChordModel>> {
  SelectedChords([List<ChordModel>? selectedItems])
      : super(selectedItems ?? []);

  List<ChordModel> get selectedItemsList => state;

  void addChord(ChordModel chordModel) {
    state = List.of(state)..add(chordModel);
  }

  void removeAll() {
    state = [];
  }
}
