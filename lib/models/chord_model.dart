import 'package:flutter/material.dart';
import 'package:scale_master_guitar/models/settings_model.dart';
import '../UI/layout/chord_container_colors.dart';
import '../hardcoded_data/flats_and_sharps_to_flats_converter.dart';
import '../hardcoded_data/flats_to_sharps_nomenclature.dart';
import '../hardcoded_data/music_constants.dart';
import '../hardcoded_data/scales/scales_data_v2.dart';

class ChordModel {
  String? chordNameForUI;
  int id;
  int position;
  int duration;
  String scale = 'Diatonic Major';
  String mode = 'Ionian';
  String bassNote;
  String parentScale;
  String parentScaleKey;
  List<String> notes;
  String? chordNameForAudio;
  String? function;
  String? chordProgression;
  String? typeOfChord;
  Color? color;
  List<String>? organizedPitches = [];
  String? originModeType;
  Settings? settings;

  ChordModel({
    required this.id,
    required this.position,
    required this.duration,
    required this.scale,
    required this.mode,
    required this.bassNote,
    required this.parentScale,
    required this.parentScaleKey,
    required this.notes,
    this.chordNameForAudio,
    this.chordNameForUI,
    this.function,
    this.chordProgression,
    this.typeOfChord,
    this.color,
    this.organizedPitches,
    this.originModeType,
    this.settings,
  }) {
    // Set other properties based on provided information
    function = _info('function');
    typeOfChord = _info('chordType');
    chordNameForUI = _getChordNameForUI();
    chordNameForAudio = flatsAndSharpsToFlats(parentScaleKey);
    color = _getColorFromFunction();
  }

  _info(String mapKey) {
    print(
        "settings!.originScale: $scale, chordProgression: $chordProgression, mapKey: $mapKey, chordNameForAudio: $parentScaleKey");

    var value = Scales.data[scale][mode][mapKey]
        [chordProgression!.indexOf(flatsAndSharpsToFlats(parentScaleKey))];

    print(value);

    return value;
  }

  String _getChordNameForUI() {
    return ['C', 'D', 'E', 'F', 'G', 'A', 'B']
            .contains(flatsAndSharpsToFlats(parentScaleKey))
        ? flatsToSharpsNomenclature(parentScaleKey)
        : parentScaleKey;
  }

  Color? _getColorFromFunction() {
    final functionValue = _info('function');
    final functionKey = functionValue.toString().toUpperCase();
    return scaleColorMap[functionKey];
  }

  String _setKey(int transposeValue) {
    int newIndex;
    (MusicConstants.notesWithFlats.indexOf(chordNameForAudio!) -
                transposeValue <
            0)
        ? newIndex = MusicConstants.notesWithFlats.indexOf(chordNameForAudio!) +
            12 -
            transposeValue
        : newIndex = MusicConstants.notesWithFlats.indexOf(chordNameForAudio!) -
            transposeValue;
    String key = MusicConstants.notesWithFlats[newIndex];
    return key;
  }

  // ScaleModel copyWith({
  //   Nullable<String>? parentScaleKey,
  //   Nullable<String>? scale,
  //   Nullable<String>? mode,
  //   Nullable<Settings>? settings,
  //   Nullable<String>? originKey,
  //   Nullable<List>? chords,
  //   Nullable<String>? chordNameForAudio,
  //   Nullable<String>? chordNameForUI,
  //   Nullable<String>? function,
  //   Nullable<String>? typeOfChord,
  //   Nullable<String>? bassNote,
  //   Nullable<Color>? color,
  //   Nullable<List<String>>? organizedPitches,
  //   Nullable<String>? originModeType,
  // }) =>
  //     ScaleModel(
  //       parentScaleKey:
  //           parentScaleKey == null ? this.parentScaleKey : parentScaleKey.value,
  //       scale: scale == null ? this.scale : scale.value,
  //       mode: mode == null ? this.mode : mode.value,
  //       chordNameForAudio: chordNameForAudio == null
  //           ? this.chordNameForAudio
  //           : chordNameForAudio.value,
  //       chords: chords == null ? this.chords : chords.value,
  //       settings: settings == null ? this.settings : settings.value,
  //     );

  @override
  String toString() {
    return 'ScaleModel(scale: $scale, mode: $mode, chordNameForAudio: $chordNameForAudio, chordNameForUI: $chordNameForUI, function: $function, chordProgression: $chordProgression, typeOfChord: $typeOfChord color: $color, organizedPitches: $organizedPitches, originModeType: $originModeType)';
  }
}
