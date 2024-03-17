import 'dart:math';

import 'package:tonic/tonic.dart';

import '../constants/flats_only_nomenclature_converter.dart';
import '../constants/music_constants.dart';
import '../constants/scales/scales_data_v2.dart';
import '../models/chord_scale_model.dart';
import '../models/settings_model.dart';

class MusicUtils {
  static List<String> createChords(
      Settings settings, String key, String scale, String mode) {
    return MusicUtils.cleanNotesIndexes(Scales.data[scale][mode]['scaleDegrees']
        .map((interval) => Pitch.parse(key) + interval)
        .toList());
  }

  static List<String> getChordInfo(
      String baseNote, ChordScaleFingeringsModel fingeringsModel, int index) {
    var mode = Scales.data[fingeringsModel.scaleModel!.scale]
        [fingeringsModel.scaleModel!.mode];

    var scaleIntervals = mode['intervals'];
    // print("chordsIntervals: $scaleIntervals");

    List<int>? newIntervals;
    if (index != 0) {
      newIntervals = calculateIntervalsForChord(index, scaleIntervals);
      // print("newIntervals: $newIntervals");
    }

    scaleIntervals = newIntervals ?? scaleIntervals;

    Map<String, int> chordIntervals = _getChordIntervals(
        scaleIntervals,
        Scales.data[fingeringsModel.scaleModel!.scale]
            [fingeringsModel.scaleModel!.mode]['scaleDegrees']);

    var chordNotes =
        createNoteList(baseNote, chordIntervals.values.toList(), 4);
    // print("Chord Notes: $chordNotes");

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

  static Map<String, int> _getChordIntervals(
      List<int> scaleIntervals, List<Interval> scaleDegrees) {
    if (scaleIntervals.length != scaleDegrees.length) {
      throw ArgumentError(
          'Scale intervals and scale degrees must have the same length');
    }

    // Create a map to store the chord intervals
    Map<String, int> chordIntervals = {};

    // Populate the chord intervals map
    for (int i = 0; i < scaleDegrees.length; i++) {
      String chordTone = _mapIntervalToChordTone(scaleDegrees[i]);
      chordIntervals[chordTone] = scaleIntervals[i];
    }

    // Reorder the chord intervals map based on the order of chord tones
    List<String> orderedChordTones = ['1', '3', '5', '7', '9', '11', '13'];
    Map<String, int> reorderedChordIntervals = {};
    for (var chordTone in orderedChordTones) {
      if (chordIntervals.containsKey(chordTone)) {
        reorderedChordIntervals[chordTone] = chordIntervals[chordTone]!;
      }
    }

    return reorderedChordIntervals;
  }

  static String filterNoteNameWithSlash(String note) {
    if (note.contains('♯') && note.contains('/')) {
      List<String> parts = note.split('/');
      return parts.length > 1 ? parts[1] : note;
    } else {
      return note;
    }
  }

  // Map<String, int> auxIntervals = {
  //   '1': 0,
  //   '3': 0,
  //   '5': 0,
  //   '7': 0,
  //   '9': 0,
  //   '11': 0,
  //   '13': 0,
  // };

  // for (int i = 0; i < auxIntervals.keys.length; i++) {
  //   var e = scaleIntervals[i];
  //   String key = auxIntervals.keys.toList()[i];

  //   if (i < 4) {
  //     auxIntervals[key] = scaleIntervals[i * 2]; //for 1,3,5
  //   }
  //   if (i == 4) {
  //     auxIntervals[key] = scaleIntervals[1] + 12; //9
  //   }
  //   if (i == 5) {
  //     auxIntervals[key] = scaleIntervals[3] + 12; //11
  //   }
  //   if (i == 6) {
  //     auxIntervals[key] = scaleIntervals[5] + 12; //13
  //   }
  // }
  // print("auxIntervals: $auxIntervals");
  // return auxIntervals;

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

  static List<String> cleanNotesNames(List<String> listOfNotes) {
    //conversion from Pitch to String with octave manipulation 'F#5' ->'Gb'+'5'
    List<String> octaveValueList = listOfNotes
        .map((n) => n
            .toString()
            .substring(n.toString().length - 1, n.toString().length))
        .toList();
    var testFlatsList = listOfNotes
        .map((note) => flatsOnlyNoteNomenclature(
            note.toString().substring(0, note.toString().length - 1)))
        .toList();
    int i = 0;
    List<String> newListOfNotes = testFlatsList
        .map((n) => (n + octaveValueList[i++]).toString())
        .toList();
    return newListOfNotes;
  }

  static List<String> cleanNotesIndexes(List<dynamic> listOfNotes) {
    List<String> testFlatsList = listOfNotes
        .map((note) {
          String noteAsString = note.toString();
          String processedNote = flatsOnlyNoteNomenclature(
              noteAsString.substring(0, noteAsString.length - 1));
          return processedNote;
        })
        .cast<String>()
        .toList(); // This cast is safe only if we're sure about the transformation result
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

  static int getHighestNoteIndex(List<String> notes) {
    int highestIndex = 0;
    for (String note in notes) {
      int noteIndex = MusicConstants.notesWithFlats.indexOf(note);
      if (noteIndex > highestIndex) {
        highestIndex = noteIndex;
      }
    }
    return highestIndex;
  }

  static int getNoteIndex(String note) {
    return MusicConstants.notesWithFlats.indexOf(note);
  }

  static String _mapIntervalToChordTone(Interval interval) {
    if (interval == Interval.P1 || interval == Interval.A1) {
      return '1';
    } else if (interval == Interval.m2 ||
        interval == Interval.M2 ||
        interval == Interval.A2) {
      return '9';
    } else if (interval == Interval.d3 ||
        interval == Interval.m3 ||
        interval == Interval.M3 ||
        interval == Interval.A3) {
      return '3';
    } else if (interval == Interval.d4 ||
        interval == Interval.P4 ||
        interval == Interval.A4) {
      return '11';
    } else if (interval == Interval.d5 ||
        interval == Interval.P5 ||
        interval == Interval.A5) {
      return '5';
    } else if (interval == Interval.m6 ||
        interval == Interval.M6 ||
        interval == Interval.A6) {
      return '13';
    } else if (interval == Interval.d7 ||
        interval == Interval.m7 ||
        interval == Interval.M7) {
      return '7';
    } else {
      throw ArgumentError('Invalid interval: $interval');
    }
  }

  static int selectRandomItem(List itemList) {
    final Random random = Random();

    int index = random.nextInt(itemList.length);
    return index;
  }

  // static String _mapIntervalToChordTone(Interval interval) {
  //   if (interval == Interval.P1) {
  //     return '1';
  //   } else if (interval == Interval.m2) {
  //     return 'b9';
  //   } else if (interval == Interval.M2) {
  //     return '9';
  //   } else if (interval == Interval.d3 || interval == Interval.m3) {
  //     return 'b3';
  //   } else if (interval == Interval.M3) {
  //     return '3';
  //   } else if (interval == Interval.d4 || interval == Interval.P4) {
  //     return '11';
  //   } else if (interval == Interval.A4) {
  //     return '#11';
  //   } else if (interval == Interval.d5 || interval == Interval.P5) {
  //     return '5';
  //   } else if (interval == Interval.A5) {
  //     return '#5';
  //   } else if (interval == Interval.m6 || interval == Interval.M6) {
  //     return '13';
  //   } else if (interval == Interval.d7 ||
  //       interval == Interval.m7 ||
  //       interval == Interval.M7) {
  //     return 'b7';
  //   } else if (interval == Interval.P8) {
  //     return '8';
  //   } else if (interval == Interval.A1) {
  //     return '#1';
  //   } else if (interval == Interval.A2) {
  //     return '#9';
  //   } else if (interval == Interval.A3) {
  //     return '#3';
  //   } else if (interval == Interval.A6) {
  //     return '#13';
  //   } else if (interval == Interval.A7) {
  //     return '#7';
  //   } else if (interval == Interval.TT) {
  //     return 'TT';
  //   } else {
  //     throw ArgumentError('Invalid interval: $interval');
  //   }
  // }
}
