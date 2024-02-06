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

  void addItem(
      {required int position,
      required ChordModel chordModel,
      required bool isBass}) {
    List<ChordModel> auxList = state;

    auxList.add(chordModel);
    state = auxList;
  }

  void removeAll() {
    state = [];
  }
}
