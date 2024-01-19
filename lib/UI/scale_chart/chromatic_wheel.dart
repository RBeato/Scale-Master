import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/top_note_provider.dart';

class ChromaticWheel extends ConsumerStatefulWidget {
  @override
  _ChromaticWheelState createState() => _ChromaticWheelState();
}

class _ChromaticWheelState extends ConsumerState<ChromaticWheel> {
  double _currentRotation = 0.0;
  static const int numStops = 12;
  final double _rotationPerStop = 2 * math.pi / numStops;
  double _dragStartRotation = 0.0;
  double _totalDeltaX = 0.0; // Added to track the total horizontal drag

  void _updateRotation(double delta) {
    _totalDeltaX += delta;
    var newRotation = _dragStartRotation +
        _totalDeltaX * 0.01; // Adjust the sensitivity if needed
    setState(() {
      _currentRotation = newRotation;
      ref.read(topNoteProvider.state).state = getTopNote();
    });
  }

  String getTopNote() {
    double topPositionAngle = -math.pi / 2;
    double adjustedRotation =
        (_currentRotation - topPositionAngle) % (2 * math.pi);
    if (adjustedRotation < 0) adjustedRotation += 2 * math.pi;

    int noteIndex = ((adjustedRotation / (2 * math.pi / 12)) % 12).floor();
    return [
      'C',
      'C#',
      'D',
      'D#',
      'E',
      'F',
      'F#',
      'G',
      'G#',
      'A',
      'A#',
      'B'
    ][noteIndex];
  }

  @override
  Widget build(BuildContext context) {
    final topNote = ref.watch(topNoteProvider);
    print(topNote);
    return GestureDetector(
      onPanStart: (details) {
        _dragStartRotation = _currentRotation;
        _totalDeltaX = 0.0; // Reset the total drag distance
      },
      onPanUpdate: (details) {
        _updateRotation(details.delta.dx);
      },
      onPanEnd: (details) {
        var closestStop =
            ((_currentRotation + _rotationPerStop / 2) / _rotationPerStop)
                .floor(); // Adjust to snap to the nearest stop
        setState(() {
          _currentRotation = closestStop * _rotationPerStop;
        });
      },
      child: CustomPaint(
        painter: WheelPainter(_currentRotation),
        child: const SizedBox(width: 300, height: 300),
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  final double rotation;
  final List<String> innerWheelNotes = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B'
  ];
  final List<String> outerWheelValues = [
    'I',
    'bii',
    'II',
    'biii',
    'III',
    'IV',
    'bv',
    'V',
    'bvi',
    'VI',
    'bvii',
    'VII'
  ];

  WheelPainter(this.rotation);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    double innerRadius = size.width / 3; // Radius for the knob

    // Draw outer wheel
    double outerRadius = size.width / 2.4; // Adjusted for visibility
    Paint outerWheelPaint = Paint()..color = Colors.transparent;
    canvas.drawCircle(center, outerRadius, outerWheelPaint);

    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    for (int i = 0; i < outerWheelValues.length; i++) {
      double angle = 2 * math.pi * i / outerWheelValues.length - math.pi / 2;
      textPainter.text = TextSpan(
        text: outerWheelValues[i],
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      );
      textPainter.layout();
      Size textSize = textPainter.size;
      Offset valuePosition = Offset(
        center.dx + outerRadius * math.cos(angle) - textSize.width / 2,
        center.dy + outerRadius * math.sin(angle) - textSize.height / 2,
      );
      textPainter.paint(canvas, valuePosition);
    }

    // Knob design (inner wheel)
    Paint knobPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: [Colors.grey[700]!, Colors.black],
      ).createShader(Rect.fromCircle(center: center, radius: innerRadius));
    canvas.drawCircle(center, innerRadius, knobPaint);

    // Markings and text on the knob
    // TextPainter textPainter = TextPainter(
    //   textDirection: TextDirection.ltr,
    //   textAlign: TextAlign.center,
    // );

    for (int i = 0; i < innerWheelNotes.length; i++) {
      double angle = 2 * math.pi * i / innerWheelNotes.length + rotation;

      // Position for the note container
      Offset containerPosition = Offset(
        center.dx + innerRadius * 0.8 * math.cos(angle),
        center.dy + innerRadius * 0.8 * math.sin(angle),
      );

      // Draw 3D-looking circular container
      Paint containerPaint = Paint()
        ..color = Colors.grey[300]!
        ..style = PaintingStyle.fill
        ..shader = RadialGradient(
          colors: [Colors.grey[400]!, Colors.grey[600]!],
          stops: const [0.5, 1.0],
        ).createShader(Rect.fromCircle(center: containerPosition, radius: 10));
      canvas.drawCircle(
          containerPosition, 20, containerPaint); // Adjust radius as needed

      // Draw shadow for 3D effect
      Paint shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(containerPosition, 20, shadowPaint);

      // Text
      // Offset notePosition = Offset(
      //   containerPosition.dx - 10, // Centering the text inside the container
      //   containerPosition.dy - 10,
      // );
      textPainter.text = TextSpan(
        text: innerWheelNotes[i],
        style: const TextStyle(color: Colors.white, fontSize: 18),
      );
      textPainter.layout();
      Size textSize = textPainter.size;
      Offset textCenter = Offset(
        containerPosition.dx - textSize.width / 2,
        containerPosition.dy - textSize.height / 2,
      );
      textPainter.paint(canvas, textCenter);
    }
  }

  @override
  bool shouldRepaint(WheelPainter oldDelegate) => true;
}
