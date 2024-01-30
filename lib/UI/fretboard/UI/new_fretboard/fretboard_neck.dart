import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard/UI/new_fretboard/scroll_widget.dart';

import '../../../../hardcoded_data/fretboard_notes.dart';
import '../../../../models/chord_scale_model.dart';
import '../../provider/fingerings_provider.dart';

class Fretboard extends ConsumerWidget {
  Fretboard({Key? key}) : super(key: key);
  // Create a ScrollController
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int stringCount = 6;
    int fretCount = 24;
    // Access properties from chordScaleFingeringsModel and customize the appearance
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);

    // Use these properties to customize the dots or text within FretboardPainter
    return fingerings.when(
        data: (chordScaleFingeringsModel) {
          return ScrollWidget(
            controller: _scrollController,
            child: CustomPaint(
              painter: FretboardPainter(
                stringCount: stringCount,
                fretCount: fretCount,
                fingeringsModel: chordScaleFingeringsModel!,
              ),
              child: SizedBox(
                width: fretCount.toDouble() * 36,
                height: stringCount.toDouble() * 24,
              ),
            ),
          );
        },
        loading: () => const CircularProgressIndicator(color: Colors.orange),
        error: (error, stackTrace) => Text('Error: $error'));
  }
}

class FretboardPainter extends CustomPainter {
  final int stringCount;
  final int fretCount;
  final ChordScaleFingeringsModel fingeringsModel;

  FretboardPainter({
    required this.stringCount,
    required this.fretCount,
    required this.fingeringsModel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // print("FingeringsModel : $fingeringsModel");

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
        final romanNumeral = _getRomanNumeral(p); // Use p instead of i
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
          Offset(centerX - textPainter.width / 2, size.height * 0.9),
        );
      }
    }

    // Draw horizontal string lines
    for (int i = 0; i < stringCount; i++) {
      double y = i * stringHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), neckPaint);
    }

    // Draw notes names where there are no dots
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
          double x = (fret - 1) *
              fretWidth; // Subtract 1 from fret to place the dot one fret to the left
          double y = (string) *
              stringHeight; // Added 0.5 to align with the center of the horizontal line

          // Calculate text position
          double textX = x + fretWidth / 2;
          double textY = y;

          String labelText = fretboardNotesNamesSharps[string][fret];
          // print(labelText);

          //(string != null) ? "$fret, $string" : "i, i";

          textPainter.text = TextSpan(
            text: labelText,
            style: const TextStyle(fontSize: 7.0, color: Colors.white),
          );
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

    // Draw dots at the specified positions
    for (final position in fingeringsModel.scaleNotesPositions!) {
      int string = position[0];
      int fret = position[1];
      // Create a TextPainter for drawing text
      TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        textScaleFactor: 1.5, // Adjust the text size as needed
      );

      // Check if the position is valid
      if (string >= 0 &&
          string < stringCount + 1 &&
          fret >= 0 && // Changed the condition to start from fret 1
          fret <= fretCount) {
        // Adjusted the condition for the last fret
        double x = (fret - 1) *
            fretWidth; // Subtract 1 from fret to place the dot one fret to the left
        double y = (string - 1) *
            stringHeight; // Added 0.5 to align with the center of the horizontal line

        // Calculate text position
        double textX = x + fretWidth / 2;
        double textY = y;

        var dotColor = Paint()
          ..color = fingeringsModel.scaleColorfulMap!["$string,$fret"]!
          ..style = PaintingStyle.fill;

        // Draw a dot at the calculated center
        canvas.drawCircle(Offset(x + fretWidth / 2, y), dotRadius, dotColor);
        // Use x + fretWidth / 2 for centerX

        String labelText = fretboardNotesNamesSharps[string][fret];

        //(string != null) ? "$fret, $string" : "i, i";

        textPainter.text = TextSpan(
          text: labelText,
          style: const TextStyle(fontSize: 7.0, color: Colors.white),
        );
        textPainter.layout();

        // Draw text at the calculated text position
        textPainter.paint(
          canvas,
          Offset(textX - textPainter.width / 2, textY - textPainter.height / 2),
        );
      }
    }
  }

  String _getRomanNumeral(int fret) {
    // Add your logic to convert fret number to Roman numeral here
    // This is a simplified example, you can use a package like 'roman' for more accurate conversions
    switch (fret) {
      case 3:
        return 'III';
      case 5:
        return 'V';
      case 7:
        return 'VII';
      case 9:
        return 'IX';
      case 12:
        return 'XII';
      case 15:
        return 'XV';
      case 17:
        return 'XVII';
      case 19:
        return 'XIX';
      case 21:
        return 'XXI';
      case 24:
        return 'XXIV';
      default:
        return '';
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // You can optimize this based on your needs
  }
}
