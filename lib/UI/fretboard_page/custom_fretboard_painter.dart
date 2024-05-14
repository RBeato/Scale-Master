import 'package:flutter/material.dart';

import '../../../constants/fretboard_notes.dart';
import '../../../models/chord_scale_model.dart';
import '../../constants/roman_numeral_converter.dart';

class CustomFretboardPainter extends CustomPainter {
  final int stringCount;
  final int fretCount;
  final ChordScaleFingeringsModel fingeringsModel;
  final List<List<bool>> dotPositions;

  CustomFretboardPainter({
    required this.stringCount,
    required this.fretCount,
    required this.fingeringsModel,
    required this.dotPositions,
  });

  static TextStyle textStyle =
      const TextStyle(fontSize: 10.0, color: Colors.white);

  @override
  void paint(Canvas canvas, Size size) {
    // print("FingeringsModel : ${fingeringsModel.chordModel}");

    var neckPaint = Paint()
      ..color = Colors.grey[700]!
      ..strokeWidth = 2.0;

    // Calculate the width and height of each fret and string
    double fretWidth = size.width / fretCount;
    double stringHeight = size.height / stringCount;

    // Calculate the radius of the dot (adjust as needed)
    double dotRadius = fretWidth / 3; // You can adjust this size

    // Draw vertical fret lines and add Roman numerals
    for (int i = 0; i < fretCount + 1; i++) {
      double x1 = i * fretWidth;
      double x2 = (i + 1) * fretWidth;
      int p = i + 1; // Increment p by 1 to match the fret numbers

      // Calculate the midpoint between the current and next vertical lines
      double centerX = (x1 + x2) / 2;

      // Adjust the strokeWidth for the first vertical line
      neckPaint.strokeWidth = (i == 0) ? 8.0 : 2.0;

      // Draw vertical fret lines
      canvas.drawLine(Offset(x1, 0), Offset(x1, size.height * 0.84), neckPaint);

      // Add Roman numerals between specific frets
      if ([3, 5, 7, 9, 12, 15, 17, 19, 21, 24].contains(p)) {
        final romanNumeral = RomanNumeralConverter.convertToFretRomanNumeral(
            p); // Use p instead of i
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: romanNumeral,
            style: const TextStyle(color: Colors.orange, fontSize: 12),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(centerX - textPainter.width / 2, size.height * 0.95),
        );
      }
    }

    // Draw horizontal string lines
    for (int i = 0; i < stringCount; i++) {
      double y = i * stringHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), neckPaint);
    }

    // Draw notes names where there are NO DOTS
    for (int string = 0; string < stringCount; string++) {
      for (int fret = 0; fret < fretCount + 1; fret++) {
        // Create a TextPainter for drawing text
        TextPainter textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          textScaleFactor: 1.5, // Adjust the text size as needed
        );

        // Check if the position is valid
        if (!fingeringsModel.scaleNotesPositions!.contains([string, fret])) {
          // Adjusted the condition for the last fret
          double x = (fret - 1) * fretWidth;
          double y = (string) * stringHeight;

          // Calculate text position
          double textX = x + fretWidth / 2;
          double textY = y;

          String labelText =
              // fingeringsModel.scaleModel!.settings!.showScaleDegrees == true
              //     ? ''
              //     :
              fretboardNotesNamesSharps[string][fret];

          textPainter.text = TextSpan(text: labelText, style: textStyle);
          textPainter.layout();

          // Draw text at the calculated text position
          textPainter.paint(
            canvas,
            Offset(
                textX - textPainter.width / 2, textY - textPainter.height / 2),
          );
        }
      }
    }

    // Draw dots based on dotPositions data
    for (int string = 0; string < stringCount; string++) {
      for (int fret = 0; fret < fretCount + 1; fret++) {
        if (dotPositions[string][fret]) {
          var dotColor = Paint()
            ..color =
                fingeringsModel.scaleModel!.settings!.isSingleColor == true
                    ? Colors.blueGrey
                    : fingeringsModel.scaleColorfulMap!["$string,$fret"]!
            ..style = PaintingStyle.fill;
          canvas.drawCircle(
              Offset(fretWidth * (fret - 1) + fretWidth / 2,
                  stringHeight * (string)),
              dotRadius,
              dotColor);

          // Create a TextPainter for drawing text
          TextPainter textPainter = TextPainter(
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            textScaleFactor: 1.5, // Adjust the text size as needed
          );

          // Check if the position is valid

          // Adjusted the condition for the last fret
          double x = (fret - 1) * fretWidth;
          double y = (string) * stringHeight;

          // Calculate text position
          double textX = x + fretWidth / 2;
          double textY = y;

          String labelText =
              // fingeringsModel.scaleModel!.settings!.showScaleDegrees == true
              //     ? ''
              //     :
              fretboardNotesNamesSharps[string][fret];

          textPainter.text = TextSpan(text: labelText, style: textStyle);
          textPainter.layout();

          // Draw text at the calculated text position
          textPainter.paint(
            canvas,
            Offset(
                textX - textPainter.width / 2, textY - textPainter.height / 2),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomFretboardPainter oldDelegate) {
    // Check if dotPositions have changed
    for (int i = 0; i < stringCount; i++) {
      for (int j = 0; j < fretCount + 1; j++) {
        if (oldDelegate.dotPositions[i][j] != dotPositions[i][j]) {
          return true; // Repaint if any dot position has changed
        }
      }
    }
    return false; // No change in dotPositions, no repaint needed
  }
}
