import 'package:flutter/material.dart';

import '../../../models/chord_scale_model.dart';

class FretboardCustomizablePainter extends StatefulWidget {
  final int stringCount;
  final int fretCount;
  final ChordScaleFingeringsModel fingeringsModel;
  final Function(List<List<int>>) onDotsUpdated;

  const FretboardCustomizablePainter({
    required this.stringCount,
    required this.fretCount,
    required this.fingeringsModel,
    required this.onDotsUpdated,
  });

  @override
  _FretboardPainterState createState() => _FretboardPainterState();
}

class _FretboardPainterState extends State<FretboardCustomizablePainter> {
  List<List<int>> dots = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        final fretWidth = MediaQuery.of(context).size.width / widget.fretCount;
        final stringHeight =
            MediaQuery.of(context).size.height / widget.stringCount;
        final fret = (details.localPosition.dx / fretWidth).floor();
        final string = (details.localPosition.dy / stringHeight).floor();

        // Check if the dot already exists, if so, remove it
        final existingDotIndex =
            dots.indexWhere((dot) => dot[0] == string && dot[1] == fret);
        if (existingDotIndex != -1) {
          setState(() {
            dots.removeAt(existingDotIndex);
            widget.onDotsUpdated(dots);
          });
        } else {
          // Add a new dot
          setState(() {
            dots.add([string, fret]);
            widget.onDotsUpdated(dots);
          });
        }
      },
      onDoubleTap: () {
        // Handle double tap to delete the last dot
        if (dots.isNotEmpty) {
          setState(() {
            dots.removeLast();
            widget.onDotsUpdated(dots);
          });
        }
      },
      child: CustomPaint(
        painter: _FretboardPainter(
          stringCount: widget.stringCount,
          fretCount: widget.fretCount,
          fingeringsModel: widget.fingeringsModel,
          dots: dots,
        ),
      ),
    );
  }
}

class _FretboardPainter extends CustomPainter {
  final int stringCount;
  final int fretCount;
  final ChordScaleFingeringsModel fingeringsModel;
  final List<List<int>> dots;

  _FretboardPainter({
    required this.stringCount,
    required this.fretCount,
    required this.fingeringsModel,
    required this.dots,
  });

  static TextStyle textStyle =
      const TextStyle(fontSize: 10.0, color: Colors.white);

  @override
  void paint(Canvas canvas, Size size) {
    // Your existing paint logic goes here
    // I'll skip it for brevity since it's unchanged

    // Draw dots based on the positions in the dots list
    final fretWidth = size.width / fretCount;
    final stringHeight = size.height / stringCount;
    final dotRadius = fretWidth / 3;

    final dotColor = Paint()..color = Colors.blueGrey;

    for (final dot in dots) {
      final string = dot[0];
      final fret = dot[1];

      // Calculate the position of the dot
      final x = (fret - 1) * fretWidth + fretWidth / 2;
      final y = (string - 1) * stringHeight;

      // Draw the dot
      canvas.drawCircle(Offset(x, y), dotRadius, dotColor);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // You can optimize this based on your needs
  }
}
