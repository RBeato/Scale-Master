import 'package:tonic/tonic.dart';

import '../hardcoded_data/flats_only_nomenclature_converter.dart';
import '../hardcoded_data/scales/scales_data_v2.dart';
import '../models/settings_model.dart';

class MusicUtils {
  static createChords(
      Settings settings, String key, String scale, String mode) {
    return MusicUtils.cleanNotesIndexes(Scales.data[scale][mode]['scaleDegrees']
        .map((interval) => Pitch.parse(key) + interval)
        .toList());
  }

  static cleanNotesNames(listOfNotes) {
    //conversion from Pitch to String with octave manipulation 'F#5' ->'Gb'+'5'
    List octaveValueList = listOfNotes
        .map((n) => n
            .toString()
            .substring(n.toString().length - 1, n.toString().length))
        .toList();
    var testFlatsList = listOfNotes
        .map((note) => flatsOnlyNoteNomenclature(
            note.toString().substring(0, note.toString().length - 1)))
        .toList();
    int i = 0;
    var newListOfNotes =
        testFlatsList.map((n) => n + octaveValueList[i++]).toList();
    return newListOfNotes;
  }

  static cleanNotesIndexes(listOfNotes) {
    var testFlatsList = listOfNotes
        .map((note) => flatsOnlyNoteNomenclature(
            note.toString().substring(0, note.toString().length - 1)))
        .toList();
    return testFlatsList;
  }
}
