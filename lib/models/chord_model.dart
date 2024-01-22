import 'package:flutter/material.dart';
import 'package:scale_master_guitar/hardcoded_data/scales_data_v2.dart';
import 'package:scale_master_guitar/models/settings_model.dart';

import '../UI/layout/chord_container_colors.dart';
import '../hardcoded_data/music_constants.dart';
import '../hardcoded_data/flats_to_sharps_nomenclature.dart';

class ChordModel {
  String? originKey;
  List? chords;
  String? chordNameForAudio;
  String? chordNameForUI;
  String? function;
  String? chordProgression;
  String? ofWhichChord;
  MainAxisAlignment typeOfChordPosition = MainAxisAlignment.start;
  String? typeOfChord;
  String? bassNote;
  Color? color;
  // String scale = 'Diatonic Major';
  List<String>? organizedPitches = [];
  String? originModeType;
  Settings? settings;

  _info(String mapKey) {
    return scalesData[settings!.originScale][chordProgression][mapKey]
        [chords!.indexOf(chordNameForAudio)];
  }

  ChordModel(
      this.chordNameForAudio, this.chords, this.chordProgression, this.settings,
      [this.typeOfChordPosition = MainAxisAlignment.end]) {
    originKey = _setKey(_info('originKey'));
    originModeType = _info('originModeType');
    function = _info('function');
    ofWhichChord = _info('functionRecipients');
    typeOfChord = _info('chordType');
    chordNameForUI = ['C', 'D', 'E', 'F', 'G', 'A', 'B'].contains(originKey)
        ? flatsToSharpsNomenclature(chordNameForAudio)
        : chordNameForAudio;
    color = scaleColorMap[_info('function')
        .toString()
        .toUpperCase()]; // Converter function para maiusculas antes de obter cor
  }

  _setKey(int transposeValue) {
    int newIndex;
    (MusicConstants.notesWithFlats.indexOf(chordNameForAudio!) -
                transposeValue <
            0)
        ? newIndex = MusicConstants.notesWithFlats.indexOf(chordNameForAudio!) +
            12 -
            transposeValue // invert interval and add
        : newIndex = MusicConstants.notesWithFlats.indexOf(chordNameForAudio!) -
            transposeValue;
    String key = MusicConstants.notesWithFlats[newIndex];
    return key;
  }

  ChordModel copyWith({
    Nullable<Settings>? settings,
    Nullable<String>? originKey,
    Nullable<List>? chords,
    Nullable<String>? chordNameForAudio,
    Nullable<String>? chordNameForUI,
    Nullable<String>? function,
    Nullable<String>? chordProgression,
    Nullable<String>? ofWichChord,
    Nullable<String>? typeOfChord,
    Nullable<String>? bassNote,
    Nullable<Color>? color,
    Nullable<List<String>>? organizedPitches,
    Nullable<String>? originModeType,
  }) =>
      ChordModel(
          chordNameForAudio == null
              ? this.chordNameForAudio
              : chordNameForAudio.value,
          chords == null ? this.chords : chords.value,
          chordProgression == null
              ? this.chordProgression
              : chordProgression.value,
          settings == null ? this.settings : settings.value,
          typeOfChordPosition = MainAxisAlignment.end);

  @override
  String toString() {
    return 'ChordModel(originKey: $originKey, chords: $chords, chordNameForAudio: $chordNameForAudio, chordNameForUI: $chordNameForUI, function: $function, chordProgression: $chordProgression, ofWhichChord: $ofWhichChord, typeOfChordPosition: $typeOfChordPosition, typeOfChord: $typeOfChord, bassNote: $bassNote, color: $color, organizedPitches: $organizedPitches, originModeType: $originModeType)';
  }
}

class Nullable<T> {
  final T _value;
  Nullable(this._value);
  T get value {
    return _value;
  }
}
