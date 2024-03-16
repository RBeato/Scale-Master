import 'package:scale_master_guitar/models/chord_model.dart';
import 'package:scale_master_guitar/utils/music_utils.dart';

class VoiceLeadingCreator {
  static List<ChordModel> buildProgression(List<ChordModel> selectedChords) {
    if (selectedChords.isEmpty) {
      return selectedChords;
    }

    // Create random inversion for the first chord
    _createFirstChordRandomInversion(selectedChords.first);

    // Create voice leading for subsequent chords
    for (int i = 1; i < selectedChords.length; i++) {
      _createVoiceLeading(selectedChords[i], selectedChords[i - 1]);
    }

    return selectedChords;
  }

  static void _createFirstChordRandomInversion(ChordModel chordModel) {
    List<String> chordNotes = chordModel.selectedChordPitches!;
    int randomInt = MusicUtils.selectRandomItem(chordNotes);
    for (int i = 0; i < randomInt - 1; i++) {
      chordNotes.add(chordNotes.first);
      chordNotes.removeAt(0);
    }
    addOctaveIndexes(chordNotes);
  }

  static void _createVoiceLeading(
      ChordModel lastChord, ChordModel secondToLastChord) {
    List<String> lastChordNotes = lastChord.selectedChordPitches!;

    List<String> reorderedChordNotes = [];
    for (var note in lastChordNotes) {
      reorderedChordNotes.add(note);
    }

    reorderedChordNotes.sort(
        (a, b) => MusicUtils.getNoteIndex(a) - MusicUtils.getNoteIndex(b));

    addOctaveIndexes(reorderedChordNotes);
    lastChord.selectedChordPitches = reorderedChordNotes;
  }

  static void addOctaveIndexes(List<String> reorderedNotes) {
    int octave = 4;
    int prevNoteIndex = -1;

    for (int i = 0; i < reorderedNotes.length; i++) {
      int noteIndex = MusicUtils.getNoteIndex(reorderedNotes[i]);
      if (noteIndex < prevNoteIndex) {
        octave++;
      }
      reorderedNotes[i] =
          reorderedNotes[i].substring(0, reorderedNotes[i].length - 1) +
              octave.toString();
      prevNoteIndex = noteIndex;
    }
  }
}
