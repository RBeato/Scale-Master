import 'package:flutter/material.dart';

class FretboardPainter extends CustomPainter {
  final int stringCount;
  final int fretCount;

  FretboardPainter({required this.stringCount, required this.fretCount});

  @override
  void paint(Canvas canvas, Size size) {
    // Define the fretboard dimensions
    final double fretboardWidth = size.width;
    final double fretboardHeight = size.height;

    // Define the fret and string spacings
    final double fretSpacing = fretboardWidth / fretCount;
    final double stringSpacing = fretboardHeight / (stringCount - 1);

    // Define paint for drawing frets and strings
    final Paint fretPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;
    final Paint stringPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    // Draw frets
    for (int i = 1; i < fretCount; i++) {
      double fretX = i * fretSpacing;
      canvas.drawLine(
        Offset(fretX, 0),
        Offset(fretX, fretboardHeight),
        fretPaint,
      );
    }

    // Draw strings
    for (int i = 0; i < stringCount; i++) {
      double stringY = i * stringSpacing;
      canvas.drawLine(
        Offset(0, stringY),
        Offset(fretboardWidth, stringY),
        stringPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // You can optimize this based on your needs
  }
}

class FretboardWidget extends StatelessWidget {
  final int stringCount;
  final int fretCount;

  FretboardWidget({required this.stringCount, required this.fretCount});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FretboardPainter(
        stringCount: stringCount,
        fretCount: fretCount,
      ),
      child: Container(),
    );
  }
}
