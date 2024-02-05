import 'dart:math';
import 'package:tonic/tonic.dart' as tonic;

import '../../../hardcoded_data/flats_only_nomenclature_converter.dart';
import '../../../hardcoded_data/music_constants.dart';
import '../../../models/selected_item.dart';

class ChordSounds {
  late List<SelectedItem> _selectedChords;
  final Map<int, String> _chordRootPositionsAndNotes = {};
  int _octave = 3;
  bool isFirstChord = true;

  Map<int, String> get bassLine => _chordRootPositionsAndNotes;
  List<SelectedItem> get chordModelAndPositions => _selectedChords;

  clearChords() {
    _selectedChords = [];
  }

  createSoundLists(List<SelectedItem> selectedItems) {
    if (selectedItems.isEmpty) return;

    _selectedChords =
        selectedItems.where((item) => item.isBass == false).toList();

    for (var item in _selectedChords) {
      var chord = tonic.Chord.parse(
          '${item.chordModel!.chordNameForAudio} ${item.chordModel!.typeOfChord}');
      var chordsList = removeOctaveIndexes(chord.pitches);
      item.chordModel!.organizedPitches = chordsList;
      _chordRootPositionsAndNotes[item.position] = chord.root.toString();
    }

    if (isFirstChord) {
      chooseFirstChordInversionRandomly();
    }
    if (!isFirstChord) {
      createVoiceLeading();
    }
    addOctaveIndexes();
    return _selectedChords;
  }

  removeOctaveIndexes(List chordsPitches) {
    int counter = 0;
    List<String> chordsPitchesList = [];
    for (var note in chordsPitches) {
      note = note.toString().substring(0, note.toString().length - 1);
      chordsPitchesList.add(note.toString());
    }
    counter++;
    //print('Original chordsPitchesList: $chordsPitchesList');
    return chordsPitchesList;
  }

  chooseFirstChordInversionRandomly() {
    _selectedChords.first.chordModel!.organizedPitches =
        _reOrderNotes(_selectedChords.first.chordModel!.organizedPitches);
    isFirstChord = false;
  }

  _reOrderNotes(notesList) {
    int randomNumber = Random().nextInt(notesList.length);
    for (int i = 0; i < randomNumber; i++) {
      notesList.add(notesList[0]);
      notesList.removeAt(0);
    }
    // print('Reordered first chord notes list: $notesList');
    return notesList;
  }

  createVoiceLeading() {
    String highestNote =
        _selectedChords.first.chordModel!.organizedPitches!.last;
    int indexOfhighestNote = MusicConstants.notesWithFlats.indexOf(highestNote);

    for (var item in _selectedChords) {
      int noteCounter = 0;
      for (var note in item.chordModel!.organizedPitches!) {
        item.chordModel!.organizedPitches![noteCounter] =
            flatsOnlyNoteNomenclature(note);
        noteCounter++;
      }

      List indexesList = [];
      for (var note in item.chordModel!.organizedPitches!) {
        indexesList.add(MusicConstants.notesWithFlats.indexOf(note));
      }
      var reorderedChordIndexes = indexesList
          .where((e) => e >= indexOfhighestNote || e <= indexOfhighestNote)
          .toList()
        ..sort();
      // print('Reordered Chord Indexes: $reorderedChordIndexes');

      List<String> reorderedChordNotes = [];
      for (var index in reorderedChordIndexes) {
        reorderedChordNotes.add(MusicConstants.notesWithFlats[index]);
      }
      item.chordModel!.organizedPitches = reorderedChordNotes;
      indexOfhighestNote = reorderedChordIndexes.last.toInt();
    }
  }

  List auxHashCodes = [];
  addOctaveIndexes() {
    for (var item in _selectedChords) {
      int auxIndexValue = 0;
      _octave = 3;
      List audioNamesNotes = item.chordModel!.organizedPitches as List<String>;

      if (!auxHashCodes.contains(item.chordModel.hashCode)) {
        //avoid adding indexes if chords are repeated
        if (isFundamentalStateChord(item)) {
          _octave++;
        } // if fundamental state increment octave
        for (int i = 0; i < audioNamesNotes.length; i++) {
          if (auxIndexValue >
              MusicConstants.notesWithFlats.indexOf(audioNamesNotes[i])) {
            _octave++;
          }
          auxIndexValue =
              MusicConstants.notesWithFlats.indexOf(audioNamesNotes[i]);
          item.chordModel!.organizedPitches![i] =
              audioNamesNotes[i] + _octave.toString();
        }
        auxHashCodes.add(item.chordModel.hashCode);
      }
      // print('SelectedChordsNotes   ${item.chordModel.organizedPitches} ');
    }
    auxHashCodes.clear();
  }

  isFundamentalStateChord(SelectedItem item) {
    int aux = 0;
    bool result = true;
    for (var index in item.chordModel!.organizedPitches!) {
      if (MusicConstants.notesWithFlats.indexOf(index) < aux) result = false;
      aux = MusicConstants.notesWithFlats.indexOf(index);
    }
    return result;
  }
}
