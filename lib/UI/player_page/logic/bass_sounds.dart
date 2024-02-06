import '../../../models/chord_model.dart';

class BassSounds {
  List<ChordModel> _bassNotesAndPositions = [];
  final int _octave = 2;

  List<ChordModel> get bassLine => _bassNotesAndPositions;

  clearBassNotes() {
    _bassNotesAndPositions = [];
  }

  createSoundLists(List<ChordModel> selectedItems) {
    if (selectedItems.isEmpty) return;
    _bassNotesAndPositions = selectedItems;
    addOctaveIndexes();
    return _bassNotesAndPositions;
  }

  List auxHashCodes = [];
  addOctaveIndexes() {
    for (var chord in _bassNotesAndPositions) {
      chord.parentScaleKey = // was bass note...

          chord.chordNameForAudio! + _octave.toString();
    }
  }
}
