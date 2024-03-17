import 'package:flutter/material.dart';

import 'scale_model.dart';

class ChordScaleFingeringsModel {
  List? scaleNotesPositions;
  List? chordVoicingNotesPositions;
  Map<String, Color>? scaleColorfulMap;
  Map<String, String>? scaleDegreesPositionsMap;
  ScaleModel? scaleModel;

  ChordScaleFingeringsModel(
      {this.chordVoicingNotesPositions,
      this.scaleNotesPositions,
      this.scaleColorfulMap,
      this.scaleDegreesPositionsMap,
      this.scaleModel});

  @override
  String toString() {
    return 'ChordScaleFingeringsModel info:'
        '\n$chordVoicingNotesPositions'
        '\n$scaleNotesPositions'
        '\n$scaleColorfulMap'
        '\n$scaleDegreesPositionsMap'
        '\n$scaleModel';
  }
}
