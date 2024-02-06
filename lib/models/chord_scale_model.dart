import 'package:flutter/material.dart';

import 'scale_model.dart';

class ChordScaleFingeringsModel {
  List? scaleNotesPositions;
  List? chordVoicingNotesPositions;
  Map<String, Color>? scaleColorfulMap;
  ScaleModel? chordModel;

  ChordScaleFingeringsModel(
      {this.chordVoicingNotesPositions,
      this.scaleNotesPositions,
      this.scaleColorfulMap,
      this.chordModel});

  @override
  String toString() {
    return 'ChordScaleFingeringsModel info:'
        '\n$chordVoicingNotesPositions'
        '\n$scaleNotesPositions'
        '\n$scaleColorfulMap'
        '\n$chordModel';
  }
}
