import 'package:tonic/tonic.dart';

import '../hardcoded_data/flats_only_nomenclature_converter.dart';
import '../hardcoded_data/scales/scales_data_v2.dart';
import '../models/chord_scale_model.dart';
import '../models/settings_model.dart';

class MusicUtils {
  static List createChords(
      Settings settings, String key, String scale, String mode) {
    return MusicUtils.cleanNotesIndexes(Scales.data[scale][mode]['scaleDegrees']
        .map((interval) => Pitch.parse(key) + interval)
        .toList());
  }

  static getChordInfo(
      String baseNote, ChordScaleFingeringsModel fingeringsModel, int index) {
    var mode = Scales.data[fingeringsModel.scaleModel!.scale]
        [fingeringsModel.scaleModel!.mode];

    var scaleIntervals = mode['intervals'];
    print("chordsIntervals: $scaleIntervals");

    List<int>? newIntervals;
    if (index != 0) {
      newIntervals = calculateIntervalsForChord(index, scaleIntervals);
      print("newIntervals: $newIntervals");
    }

    scaleIntervals = newIntervals ?? scaleIntervals;

    Map<String, int> chordIntervals = getChordIntervals(scaleIntervals);

    var chordNotes =
        createNoteList(baseNote, chordIntervals.values.toList(), 4);
    print("Chord Notes: $chordNotes");

    // var getchordNotes(auxIntervals, auxDisplacementValue, selectedChord);

    return chordNotes;
  }

  static List<int> calculateIntervalsForChord(
      int selectedChordIndex, List initialIntervals) {
    // Define the initial intervals for the Ionian scale

    List<int> appendingIntervals = [];
    List<int> intervals = [];
    for (int i = 0; i < initialIntervals.length; i++) {
      if (i < selectedChordIndex) {
        var interval = (initialIntervals[i] + 12);
        interval = interval - selectedChordIndex - 1;
        appendingIntervals.add(interval);
      } else {
        var interval = initialIntervals[i] - selectedChordIndex - 1;
        intervals.add(interval);
      }
    }

    intervals.addAll(appendingIntervals);

    return intervals;
  }

  static Map<String, int> getChordIntervals(scaleIntervals) {
    Map<String, int> auxIntervals = {
      '1': 0,
      '3': 0,
      '5': 0,
      '7': 0,
      '9': 0,
      '11': 0,
      '13': 0,
    };

    for (int i = 0; i < auxIntervals.keys.length; i++) {
      var e = scaleIntervals[i];
      String key = auxIntervals.keys.toList()[i];

      if (i < 4) {
        auxIntervals[key] = scaleIntervals[i * 2]; //for 1,3,5
      }
      if (i == 4) {
        auxIntervals[key] = scaleIntervals[1] + 12; //9
      }
      if (i == 5) {
        auxIntervals[key] = scaleIntervals[3] + 12; //11
      }
      if (i == 6) {
        auxIntervals[key] = scaleIntervals[5] + 12; //13
      }
    }
    print("auxIntervals: $auxIntervals");
    return auxIntervals;
  }

  static List<String> createNoteList(
      String baseNote, List<int> intervals, int octave) {
    List<String> notes = [];

    String cleanedNoteName = extractNoteName(baseNote);

    String noteToFlats = flatsOnlyNoteNomenclature(cleanedNoteName);

    // Parse the base note
    var basePitch = Pitch.parse(noteToFlats);

    // Calculate notes for each interval
    for (int interval in intervals) {
      // Calculate the MIDI number by adding the interval to the base note's MIDI number
      int midiNumber = basePitch.midiNumber + interval;

      // Create a new pitch object from the MIDI number and octave
      var pitch = Pitch.fromMidiNumber(midiNumber);

      // Add the pitch representation to the list of notes
      notes.add(pitch.toString());
    }

    return notes;
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

  static List cleanNotesIndexes(listOfNotes) {
    var testFlatsList = listOfNotes
        .map((note) => flatsOnlyNoteNomenclature(
            note.toString().substring(0, note.toString().length - 1)))
        .toList();
    return testFlatsList;
  }

  static String extractNoteName(String chordType) {
    // Define a regular expression pattern to match note names and symbols
    RegExp regex = RegExp(r'([A-Ga-g][♭♯]?)');

    // Extract all note names and symbols from the chord type
    Iterable<Match> matches = regex.allMatches(chordType);

    // Return the first match found (which represents the note name)
    return matches.isNotEmpty ? matches.first.group(0)! : chordType;
  }
}
