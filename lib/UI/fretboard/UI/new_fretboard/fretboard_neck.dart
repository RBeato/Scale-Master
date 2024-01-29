import 'package:flutter/material.dart';

class FretboardNeck extends StatelessWidget {
  final int stringCount;
  final int fretCount;

  const FretboardNeck({required this.stringCount, required this.fretCount});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: FretboardNeckPainter(
          stringCount: stringCount,
          fretCount: fretCount,
        ),
        child: const Text(
          'A',
          style: TextStyle(color: Colors.white),
        ));
  }
}

class FretboardNeckPainter extends CustomPainter {
  final int stringCount;
  final int fretCount;

  FretboardNeckPainter({required this.stringCount, required this.fretCount});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    // Calculate the width and height of each fret and string
    double fretWidth = size.width / fretCount;
    double stringHeight = size.height / stringCount;

    // Draw vertical fret lines
    for (int i = 1; i < fretCount; i++) {
      double x = i * fretWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal string lines
    for (int i = 1; i < stringCount; i++) {
      double y = i * stringHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // You can optimize this based on your needs
  }
}
