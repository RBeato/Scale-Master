import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../hardcoded_data/music_constants.dart';
import '../../../models/chord_model.dart';
import '../../../models/thrash_chord_model.dart';

class SelectedItem {
  int id;
  int position;
  ChordModel? chordModel;
  bool isBass;
  SelectedItem(
      {this.id = 0, this.position = 0, this.chordModel, this.isBass = false});

  @override
  String toString() {
    return 'SelectedItem(id: $id, position: $position, chordModel: $chordModel, isBass: $isBass)';
  }
}

final selectedItemsProvider = StateNotifierProvider((ref) => SelectedItems());

class SelectedItems extends StateNotifier<List<SelectedItem>> {
  SelectedItems([List<SelectedItem>? selectedItems])
      : super(selectedItems ?? []);

  final String _addSemiTone = 'add';
  final String _subtractSemiTone = 'subtract';

  List<SelectedItem> get selectedItemsList => state;

  void addItem(
      {required int position,
      required ChordModel chordModel,
      required bool isBass}) {
    List<SelectedItem> auxList = state;
    ChordModel cModel = chordModel.copyWith();

    auxList.add(SelectedItem(
      id: state.length + 1,
      position: position,
      chordModel: cModel,
      isBass: isBass,
    ));
    state = auxList;
  }

  void removeItem(TrashChordModel selectedItem) {
    state = state
        .where((item) =>
            item.position != selectedItem.positionIndex ||
            item.isBass != selectedItem.isBassNote)
        .toList();
    print('REMOVE ITEM state: $state');
  }

  void removeAll() {
    state = [];
  }

  void decreaseKey() {
    ChordModel selectedItem;
    List<SelectedItem> auxList = [];
    for (final item in state) {
      selectedItem =
          newChordModel(item.chordModel as ChordModel, _subtractSemiTone);
      auxList.add(SelectedItem(
          id: item.id,
          position: item.position,
          chordModel: selectedItem,
          isBass: item.isBass));
    }
    state = [...auxList];
  }

  void increaseKey() {
    ChordModel selectedItem;
    List<SelectedItem> auxList = [];
    for (final item in state) {
      selectedItem = newChordModel(item.chordModel as ChordModel, _addSemiTone);
      auxList.add(SelectedItem(
          id: item.id,
          position: item.position,
          chordModel: selectedItem,
          isBass: item.isBass));
    }
    state = [...auxList];
  }

  newChordModel(ChordModel item, String operation) {
    if (item.chords != null && item.chords!.isNotEmpty) {
      item.chords = item.chords!
          .map((e) =>
              MusicConstants.notesWithFlats[createNewIndex(e, operation)])
          .toList();
    }
    item.chordNameForUI = MusicConstants.notesWithFlats[
        createNewIndex(item.chordNameForAudio as String, operation)];
    item.chordNameForAudio = MusicConstants.notesWithFlats[
        createNewIndex(item.chordNameForAudio as String, operation)];
    item.originKey = MusicConstants
        .notesWithFlats[createNewIndex(item.originKey as String, operation)];
    return item;
  }

  createNewIndex(String noteName, String operation) {
    int newIndex;
    int noteIndex = MusicConstants.notesWithFlats.indexOf(noteName);
    if (operation == _addSemiTone) {
      noteIndex == MusicConstants.notesWithFlats.length - 1
          ? newIndex = 0
          : newIndex = noteIndex + 1;
    } else {
      noteIndex == 0
          ? newIndex = MusicConstants.notesWithFlats.length - 1
          : newIndex = noteIndex - 1;
    }
    return newIndex;
  }
}
