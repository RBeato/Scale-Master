import 'package:flutter/material.dart';
import 'package:scale_master_guitar/hardcoded_data/scales/scales_data_v2.dart';
import 'package:scale_master_guitar/models/settings_model.dart';

import '../UI/layout/chord_container_colors.dart';
import '../hardcoded_data/flats_and_sharps_to_flats_converter.dart';
import '../hardcoded_data/music_constants.dart';
import '../hardcoded_data/flats_to_sharps_nomenclature.dart';

class ChordModel {
  String parentScaleKey = 'C';
  String? scale;
  String? mode;
  List? chords;
  String? chordNameForAudio;
  String? chordNameForUI;
  String? function;
  String? chordProgression;
  String? typeOfChord;
  Color? color;
  List<String>? organizedPitches = [];
  String? originModeType;
  Settings? settings;

  _info(String mapKey) {
    print(
        "settings!.originScale: $scale, chordProgression: $chordProgression, mapKey: $mapKey, chordNameForAudio: $parentScaleKey");

    var value = Scales.data[scale][mode][mapKey]
        [chords!.indexOf(flatsAndSharpsToFlats(parentScaleKey))];

    // var value = scalesData[chordProgression][mapKey]
    //     [chords!.indexOf(chordNameForAudio)];
    print(value);

    return value;
  }

  ChordModel({
    this.parentScaleKey = 'C',
    this.scale,
    this.mode,
    this.chordNameForAudio,
    this.chords,
    this.settings,
  }) {
    scale = scale ?? 'Diatonic Major';
    mode = mode ?? 'Ionian';
    function = _info('function');
    typeOfChord = _info('chordType'); //TODO: Review this
    chordNameForUI = ['C', 'D', 'E', 'F', 'G', 'A', 'B']
            .contains(flatsAndSharpsToFlats(parentScaleKey))
        ? flatsToSharpsNomenclature(parentScaleKey)
        : parentScaleKey;
    chordNameForAudio = flatsAndSharpsToFlats(parentScaleKey);
    color = scaleColorMap[_info('function')
        .toString()
        .toUpperCase()]; // Convert function to uppercase before getting the color
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
    Nullable<String>? parentScaleKey,
    Nullable<String>? scale,
    Nullable<String>? mode,
    Nullable<Settings>? settings,
    Nullable<String>? originKey,
    Nullable<List>? chords,
    Nullable<String>? chordNameForAudio,
    Nullable<String>? chordNameForUI,
    Nullable<String>? function,
    Nullable<String>? typeOfChord,
    Nullable<String>? bassNote,
    Nullable<Color>? color,
    Nullable<List<String>>? organizedPitches,
    Nullable<String>? originModeType,
  }) =>
      ChordModel(
        parentScaleKey:
            parentScaleKey == null ? this.parentScaleKey : parentScaleKey.value,
        scale: scale == null ? this.scale : scale.value,
        mode: mode == null ? this.mode : mode.value,
        chordNameForAudio: chordNameForAudio == null
            ? this.chordNameForAudio
            : chordNameForAudio.value,
        chords: chords == null ? this.chords : chords.value,
        settings: settings == null ? this.settings : settings.value,
      );

  @override
  String toString() {
    return 'ScaleModel(scale: $scale, mode: $mode, chords: $chords, chordNameForAudio: $chordNameForAudio, chordNameForUI: $chordNameForUI, function: $function, chordProgression: $chordProgression,  typeOfChord: $typeOfChord color: $color, organizedPitches: $organizedPitches, originModeType: $originModeType)';
  }
}

class Nullable<T> {
  final T _value;
  Nullable(this._value);
  T get value {
    return _value;
  }
}
