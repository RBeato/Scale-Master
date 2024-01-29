import 'package:flutter/material.dart';

import '../../../hardcoded_data/fretboard_notes.dart';
import '../../../models/chord_scale_model.dart';

class FretboardPainter extends CustomPainter {
  final int stringIndex;
  final int frets;
  final double dotWidth;

  FretboardPainter(this.stringIndex, this.frets, this.dotWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dotPaint = Paint()..color = Colors.black;

    for (int fretIndex = 0; fretIndex < frets; fretIndex++) {
      final double centerX = (fretIndex + 0.5) * dotWidth;
      final double centerY = size.height / 2;

      canvas.drawCircle(Offset(centerX, centerY), dotWidth / 2, dotPaint);

      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: 'F${(fretIndex + 1).toString()})',
          style: const TextStyle(color: Colors.white),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: dotWidth);

      final double textX = centerX - textPainter.width / 2;
      final double textY = centerY - textPainter.height / 2;

      textPainter.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

buildFretboardNotesNames(ChordScaleFingeringsModel fingerings, int i, int j) {
  String noteName;

  // print("NOTE INFO:  $noteInfo");
  if (['C', 'D', 'E', 'F', 'G', 'A', 'B']
      .contains(fingerings.chordModel!.parentScaleKey)) {
    noteName = fretboardNotesNamesSharps[i][j];
  } else {
    noteName = fretboardNotesNamesFlats[i][j];
  }
  return noteName;
}

createPositionColor({
  required int stringNumber,
  required int fretNumber,
  ChordScaleFingeringsModel? positionsInfo,
}) {
  if (positionsInfo != null) {
    List chordPositions = positionsInfo.chordVoicingNotesPositions as List;
    List scalesPositions = positionsInfo.scaleNotesPositions as List;
    Map colorfulPosition = positionsInfo.scaleColorfulMap as Map;

    stringNumber = stringNumber + 1;
    Color? color;
    if (chordPositions.isEmpty) {
      return colorfulPosition["$stringNumber,$fretNumber"];
    } else {
      for (int i = 0; i < scalesPositions.length; i++) {
        for (int j = 0; j < chordPositions.length; j++) {
          if (chordPositions[j][0] == stringNumber &&
              chordPositions[j][1] == fretNumber) {
            if (fretNumber == 0) {
              color = Colors.greenAccent[100];
            } else {
              color = Colors.greenAccent;
            }

            break;
          }
          if (scalesPositions[i][0] == stringNumber &&
              scalesPositions[i][1] == fretNumber) {
            if (fretNumber == 0) {
              color = Colors.blueGrey;
            } else {
              color = Colors.blue[300];
            }
          }
        }
      }
    }
    return color;
  }
}
