import '../../../models/selected_item.dart';

class BassSounds {
  List<SelectedItem> _bassNotesAndPositions = [];
  final int _octave = 2;

  List<SelectedItem> get bassLine => _bassNotesAndPositions;

  clearBassNotes() {
    _bassNotesAndPositions = [];
  }

  createSoundLists(List<SelectedItem> selectedItems) {
    if (selectedItems.isEmpty) return;
    _bassNotesAndPositions = selectedItems;
    addOctaveIndexes();
    return _bassNotesAndPositions;
  }

  List auxHashCodes = [];
  addOctaveIndexes() {
    for (var element in _bassNotesAndPositions) {
      element.chordModel!.parentScaleKey = // was bass note...

          element.chordModel!.chordNameForAudio! + _octave.toString();
    }
  }
}
