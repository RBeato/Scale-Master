import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tonic/tonic.dart' as tonic;

import '../../layout/chord_container_colors.dart';
import '../../../hardcoded_data/music_constants.dart';
import '../../../hardcoded_data/flats_only_nomenclature_converter.dart';
import '../../../hardcoded_data/fretboard_notes.dart';
import '../../../hardcoded_data/scales_data_v2.dart';
import '../../../hardcoded_data/tonic_harmonic_minor_aux_bug.dart';
import '../../../models/chord_model.dart';
import '../../../models/chord_scale_model.dart';
import '../../../models/settings_model.dart';

class FingeringsColorBloc {
  String? _modeOption;
  int? _numberOfChordNotes;
  String? _chordVoicings;
  late String _lowestNoteStringOption;
  late bool _scaleAndChordSelection;
  late String _key;
  late String _chordName;

  List? _voicingIntervalsNumbers;
  List? _lowerStringList;
  List? _stringDistribution;

  List? _modeIntervals;
  List? _modeNotes;
  List<tonic.Interval>? _voicingTonicIntervalList;
  List _chordNotesPositions = [];
  List _scaleNotesPositions = [];
  Map<String, Color> _scaleColorfulMap = {};

  int scaleDegree = 0;

  ChordScaleFingeringsModel _scaleChordPositions = ChordScaleFingeringsModel();
  ChordScaleFingeringsModel get scaleChordPositions => _scaleChordPositions;
  static late Map chordsAndTrackPositions;

  resetScaleChords() {
    _scaleChordPositions = ChordScaleFingeringsModel();
  }

  settingsChanged(Settings settings) {
    _key = MusicConstants.notesWithFlats[settings.musicKey.toInt()];
    _modeOption = settings.originScale;
    _chordVoicings = settings.chordVoicingOption;
    _lowestNoteStringOption = settings.bottomNoteStringOption;
    _scaleAndChordSelection = settings.scaleAndChordsOption;
  }

  ChordScaleFingeringsModel createChordsScales(
      ChordModel chordModel, Settings settings) {
    settingsChanged(settings);

    _key = chordModel.parentScaleKey;
    _modeOption = chordModel.mode;
    _chordName = chordModel.chordNameForAudio as String;
    _numberOfChordNotes = chordModel.organizedPitches!.length;
    return createFretboardPositions(chordModel);
  }

  createFretboardPositions(ChordModel chordModel) {
    setModeDegrees();
    checkLowestStringSelection();
    filterSettings();
    buildVoicingIntervalsList();
    chordsStringFretPositions();
    scalesStringFretPositions();
    print(_scaleChordPositions);

    _scaleChordPositions = ChordScaleFingeringsModel(
        chordModel: chordModel,
        chordVoicingNotesPositions: _chordNotesPositions,
        scaleNotesPositions: _scaleNotesPositions,
        scaleColorfulMap: _scaleColorfulMap);

    _chordNotesPositions = [];
    _scaleNotesPositions = [];
    _scaleColorfulMap = {};

    return _scaleChordPositions;
  }

  setModeDegrees() {
    late String mainScale;
    for (var element in Scales.data.keys) {
      if (Scales.data[element]['modeNames'].contains(_modeOption)) {
        mainScale = element;
      } else {
        debugPrint("Mode not found");
        continue;
      }
    }

    if (mainScale == 'Harmonic Minor') {
      //bug in tonic. Added aux data
      _modeIntervals = harmonicMinorModes[_modeOption];
    } else {
      final scalePattern = tonic.ScalePattern.findByName(mainScale);
      _modeIntervals = scalePattern.modes[_modeOption]!.intervals;
    }
  }

  checkLowestStringSelection() {
    try {
      if (_lowestNoteStringOption.contains('all 3')) {
        _lowerStringList = [6, 5, 4];
      }
      if (_lowestNoteStringOption.contains('both')) {
        _lowerStringList = [6, 5];
      }
      if (_lowestNoteStringOption.contains('none')) {
        _lowerStringList = [6, 5, 4, 3, 2, 1];
      } else {
        _lowerStringList = [int.parse(_lowestNoteStringOption)];
      }
    } catch (e) {
      // print('Check lowest string selection function: $e');
    }
  }

  filterSettings() {
    int randomChoice = Random().nextInt(2);

    if (_numberOfChordNotes == 3) {
      switch (_chordVoicings) {
        case 'All chord tones':
          _voicingIntervalsNumbers = [1, 3, 5];

          /// _stringDistriuitions is in all strings
          break;
        case 'Close voicings':
          _voicingIntervalsNumbers = [1, 3, 5];
          _stringDistribution = [0, -1, -2];
          break;
        case 'CAGED':
          _voicingIntervalsNumbers = [1, 3, 5]; //not used
          _stringDistribution = []; //not used
          break;
        case 'Drop':
          _voicingIntervalsNumbers = [1, 5, 3];
          _stringDistribution = [0, -1, -3];
          break;
        default:
      }
    }
    if (_numberOfChordNotes == 4) {
      switch (_chordVoicings) {
        case 'All chord tones':
          _voicingIntervalsNumbers = [1, 3, 5, 7];
          // _stringDistriuitions is in all strings
          break;
        case 'Close voicings':
          _voicingIntervalsNumbers = [1, 3, 5, 7];
          _stringDistribution = [0, -1, -2, -3];
          break;
        case 'Drop':
          if (randomChoice == 1) {
            //Drop2
            // print('RANDOM  CHOICE: DROP2');
            _voicingIntervalsNumbers = [1, 5, 7, 3];
            _stringDistribution = [0, -1, -2, -3];
          } else {
            // 'Drop 3'
            // print('RANDOM  CHOICE: DROP3');
            _stringDistribution = [0, -2, -3, -4];
            _voicingIntervalsNumbers = [1, 7, 3, 5];
          }
          break;
        case 'CAGED':
          //* Special case
          _voicingIntervalsNumbers = [1, 3, 5, 7]; //not used
          _stringDistribution = []; //not used
          break;
        default:
      }
    }
  }

  buildVoicingIntervalsList() {
    _voicingTonicIntervalList = [];
    if (_voicingIntervalsNumbers == null) {
      return;
    } //TODO: Review if this is needed
    for (var element in _voicingIntervalsNumbers!) {
      _voicingTonicIntervalList!.add(_modeIntervals![element - 1]);
    }
    // print('VoicingNotesList: $_voicingTonicIntervalList');
  }

  chordsStringFretPositions() {
//!! Inserir passo intermédio que permite
//!! dar cores diferentes a posições diferentes
    if (_scaleAndChordSelection == false) {
      _chordNotesPositions = [];
    } else if (_scaleAndChordSelection == true) {
      _chordNotesPositions = [];
      late int auxValue;
      int string;
      String noteName;
      String noteNameWithoutIndex;
      int fret;
      //CHORD VOICINGS == 'ALL CHORD TONES'
      if (_chordVoicings == 'All chord tones') {
        List<int> noteRepetitionsInOneString = [0, 2];
        for (int i = 0; i < _lowerStringList!.length; i++) {
          for (int j = 0; j < _voicingTonicIntervalList!.length; j++) {
            noteName =
                (tonic.Pitch.parse(_chordName) + _voicingTonicIntervalList![j])
                    .toString();
            noteNameWithoutIndex =
                noteName.substring(0, noteName.toString().length - 1);
            noteNameWithoutIndex =
                flatsOnlyNoteNomenclature(noteNameWithoutIndex);
            string = _lowerStringList![i]; //strings between 0-5

            for (int n = 0; n < noteRepetitionsInOneString.length; n++) {
              fret = fretboardNotesNamesFlats[string - 1]
                  .indexOf(noteNameWithoutIndex, noteRepetitionsInOneString[n]);
              if (n == 1 && fret == auxValue) {
                continue;
              }
              auxValue = fret;
              _chordNotesPositions.add([string, fret]);
            }
          }
        }
        // print('\"All chord tones\" chordNotesPositions: $_chordNotesPositions');
      }
      if (_chordVoicings == 'CAGED') {
        //CAGED NOTES POSITIONS
        //!!ADD CAGED TYPE TO 7TH CHORDS.?
        final chordType =
            tonic.ChordPattern.fromIntervals(_voicingTonicIntervalList!);
        // print('_key $_key chordType; $chordType');
        // print(tonic.Chord.parse('$_key $chordType'));
        final chord = tonic.Chord.parse('$_chordName $chordType');
        final instrument = tonic.Instrument.guitar;
        final fretting = tonic.bestFrettingFor(chord, instrument).toString();
        // print('Fretting : $fretting');
        try {
          int stringNumber = 6;
          for (int i = 0; i < 6; i++) {
            var fret = fretting.substring(i, i + 1);
            if (fret != 'x') {
              _chordNotesPositions.add([stringNumber, int.parse(fret)]);
              stringNumber--;
            } else {
              stringNumber--;
            }
          }
          // print('_chordNotesPositions $_chordNotesPositions');
        } catch (e) {
          print('Parsing error: $e');
        }
      }
      //CHORD VOICINGS == 'drop2' || ChordVoicings == 'drop3'|| ChordVoicings == 'close voicing'
      if (_chordVoicings == 'Close voicings' || _chordVoicings == 'Drop') {
        List<int> proximityList = [];
        List<int> notesRepetitionsInOneString = [0, 2];

        for (int i = 0; i < _voicingTonicIntervalList!.length; i++) {
          for (int j = 0; j < _lowerStringList!.length; j++) {
            for (int k = 0; k < notesRepetitionsInOneString.length; k++) {
              string = _lowerStringList![j] +
                  _stringDistribution![i]; //strings indexes between 0-5
              noteName = (tonic.Pitch.parse(_chordName) +
                      _voicingTonicIntervalList![i])
                  .toString();
              noteNameWithoutIndex =
                  noteName.substring(0, noteName.toString().length - 1);
              noteNameWithoutIndex =
                  flatsOnlyNoteNomenclature(noteNameWithoutIndex);
              if (string == 0) {
                print("STRING == 0");
              }
              fret = fretboardNotesNamesFlats[string - 1].indexOf(
                  noteNameWithoutIndex, notesRepetitionsInOneString[k]);
              if (k > 0 && fret == auxValue) {
                continue;
              }
              auxValue = fret;
              proximityList.add(fret);
              _chordNotesPositions.add([string, fret]);
              // print('_proximityList : $_proximityList');
              // print('_chordNotesPositions: $_chordNotesPositions');
            }
          }
          //Calculate the average value fret for the chord and correct the position
          var averageFretPosition =
              proximityList.map((m) => m).reduce((a, b) => a + b) /
                  proximityList.length;
          print('Average result: $averageFretPosition');

          for (int frt = 0; frt < _chordNotesPositions.length; frt++) {
            _chordNotesPositions.removeWhere((item) =>
                item[1] < averageFretPosition - 6.5 ||
                item[1] > averageFretPosition + 6.5);
          }
        }
      }
    }
  }

  scalesStringFretPositions() {
    //!Add scale degree here
    _modeNotes = _modeIntervals!
        .map((interval) => tonic.Pitch.parse(_chordName) + interval)
        .toList();
    _modeNotes = _modeNotes!
        .map((e) => e.toString().substring(0, e.toString().length - 1))
        .toList();
    _modeNotes = _modeNotes!.map((e) => flatsOnlyNoteNomenclature(e)).toList();
    // print('ModeNotes: ${_modeNotes}');

    var notesRepetitionsInOneString = [0, 2, 3];
    for (int string = 0; string < 6; string++) {
      for (int noteIndex = 0; noteIndex < _modeNotes!.length; noteIndex++) {
        for (int n = 0; n < notesRepetitionsInOneString.length; n++) {
          int fret = fretboardNotesNamesFlats[string].indexOf(
            _modeNotes![noteIndex],
            notesRepetitionsInOneString[n],
          );
          bool contains = false;
          for (var k in _scaleNotesPositions) {
            if (k[0] == string + 1 && k[1] == fret) contains = true;
          }
          if (contains == false) {
            _scaleNotesPositions.add([string + 1, fret]);
            _scaleColorfulMap["${string + 1},$fret"] =
                scaleTonicColorMap[_modeIntervals![noteIndex]]!;
          }
        }
      }
    }
    //! IF 'scalesOnly' is selected and IF brainin colors are selected show colorful fretboard
    // print('_scaleNotesPositions $_scaleNotesPositions');
  }

  Map cagedVoicings = {
    'C': {'5': 1, '4': 3, '3': 5, '2': 1, '1': 1},
    'A': {'5': 1, '4': 5, '3': 1, '2': 3, '1': 5},
    'G': {'6': 1, '5': 3, '4': 5, '3': 1, '2': 3, '1': 1},
    'E': {'6': 1, '5': 5, '4': 1, '3': 3, '2': 5, '1': 1},
    'D': {'4': 1, '3': 5, '2': 1, '1': 3},
  };
}
