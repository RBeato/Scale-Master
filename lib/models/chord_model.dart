import 'package:flutter/material.dart';
import 'package:scale_master_guitar/models/settings_model.dart';
import '../UI/layout/chord_container_colors.dart';
import '../hardcoded_data/flats_and_sharps_to_flats_converter.dart';
import '../hardcoded_data/flats_to_sharps_nomenclature.dart';
import '../utils/music_utils.dart';

class ChordModel {
  String noteName;
  String? chordNameForUI;
  int id;
  int position;
  int duration;
  String scale = 'Diatonic Major';
  String mode = 'Ionian';
  String bassNote;
  String originalScaleType;
  String parentScaleKey;
  List<String> chordNotesWithIndexesUnclean;
  String? chordNameForAudio;
  String? function;
  String? typeOfChord;
  Color? color;
  List<String>? allChordExtensions;
  List<String>? selectedChordPitches;
  String? originModeType;
  Settings? settings;
  String? chordFunction;
  String? chordDegree;

  ChordModel({
    required this.noteName,
    required this.id,
    required this.position,
    required this.duration,
    required this.scale,
    required this.mode,
    required this.bassNote,
    required this.chordFunction,
    required this.chordDegree,
    required this.originalScaleType,
    required this.parentScaleKey,
    required this.chordNotesWithIndexesUnclean,
    this.chordNameForAudio,
    this.chordNameForUI,
    this.function,
    // this.chordProgression,
    this.typeOfChord,
    this.color,
    this.allChordExtensions,
    this.selectedChordPitches,
    this.originModeType,
    this.settings,
  }) {
    // Set other properties based on provided information
    // function = _info('function');
    // typeOfChord = _info('chordType');
    chordNameForUI = _getChordNameForUI();
    chordNameForAudio = flatsAndSharpsToFlats(parentScaleKey);
    color = _getColorFromFunction();
    allChordExtensions = _getOrganizedPitches();
  }

  List<String> _getOrganizedPitches() {
    List<String> pitches =
        MusicUtils.cleanNotesNames(chordNotesWithIndexesUnclean);
    // for (var i = 0; i < notes.length; i++) {
    //   pitches.add(flatsAndSharpsToFlats(note));
    // }
    return pitches;
  }

  String _getChordNameForUI() {
    return ['C', 'D', 'E', 'F', 'G', 'A', 'B']
            .contains(flatsAndSharpsToFlats(parentScaleKey))
        ? flatsToSharpsNomenclature(parentScaleKey)
        : parentScaleKey;
  }

  Color? _getColorFromFunction() {
    final functionKey = chordDegree.toString().toUpperCase();
    return scaleColorMap[functionKey];
  }

  ChordModel copyWith({
    String? noteName,
    String? chordNameForUI,
    int? id,
    int? position,
    int? duration,
    String? scale,
    String? mode,
    String? bassNote,
    String? originalScaleType,
    String? parentScaleKey,
    List<String>? chordNotesWithIndexesUnclean,
    String? chordNameForAudio,
    String? function,
    String? typeOfChord,
    Color? color,
    List<String>? allChordExtensions,
    List<String>? selectedChordPitches,
    String? originModeType,
    Settings? settings,
    String? chordFunction,
    String? chordDegree,
  }) {
    return ChordModel(
      noteName: noteName ?? this.noteName,
      chordNameForUI: chordNameForUI ?? this.chordNameForUI,
      id: id ?? this.id,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      scale: scale ?? this.scale,
      mode: mode ?? this.mode,
      bassNote: bassNote ?? this.bassNote,
      originalScaleType: originalScaleType ?? this.originalScaleType,
      parentScaleKey: parentScaleKey ?? this.parentScaleKey,
      chordNotesWithIndexesUnclean:
          chordNotesWithIndexesUnclean ?? this.chordNotesWithIndexesUnclean,
      chordNameForAudio: chordNameForAudio ?? this.chordNameForAudio,
      function: function ?? this.function,
      typeOfChord: typeOfChord ?? this.typeOfChord,
      color: color ?? this.color,
      allChordExtensions:
          allChordExtensions ?? selectedChordPitches, // Update organizedPitches
      selectedChordPitches: selectedChordPitches ?? this.selectedChordPitches,
      originModeType: originModeType ?? this.originModeType,
      settings: settings ?? this.settings,
      chordFunction: chordFunction ?? this.chordFunction,
      chordDegree: chordDegree ?? this.chordDegree,
    );
  }

  @override
  String toString() {
    return 'ScaleModel(scale: $scale, mode: $mode, chordNameForAudio: $chordNameForAudio, chordNameForUI: $chordNameForUI, function: $function,typeOfChord: $typeOfChord color: $color, selectedChordPitches: $selectedChordPitches,allChordExtension $allChordExtensions, originModeType: $originModeType)';
  }
}
