import 'package:flutter/material.dart';

class FretboardDot extends StatelessWidget {
  final int stringCount;
  final int fretCount;

  const FretboardDot({required this.stringCount, required this.fretCount});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: FretboardPainter(
          stringCount: stringCount,
          fretCount: fretCount,
        ),
        child: const Text(
          'A',
          style: TextStyle(color: Colors.white),
        ));
  }
}

class FretboardPainter extends CustomPainter {
  final int stringCount;
  final int fretCount;

  FretboardPainter({required this.stringCount, required this.fretCount});

  @override
  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    var paint = Paint()..color = Colors.blue;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(center.width, center.height),
        height: 30,
        width: 30,
      ),
      0.5,
      2 * 3.14,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // You can optimize this based on your needs
  }
}
