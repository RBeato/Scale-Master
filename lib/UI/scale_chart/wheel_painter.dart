// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class WheelPainter extends CustomPainter {
//   final double rotation;
//   final List<String> notes = [
//     'C',
//     'C#',
//     'D',
//     'D#',
//     'E',
//     'F',
//     'F#',
//     'G',
//     'G#',
//     'A',
//     'A#',
//     'B'
//   ];

//   WheelPainter(this.rotation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     double radius = size.width / 2;
//     Offset center = Offset(size.width / 2, size.height / 2);
//     Paint paint = Paint()..color = Colors.blue;
//     TextPainter textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//       textAlign: TextAlign.center,
//     );

//     for (int i = 0; i < notes.length; i++) {
//       double angle = 2 * math.pi * i / notes.length + rotation;
//       Offset notePosition = Offset(
//         center.dx + radius * math.cos(angle) - 10,
//         center.dy + radius * math.sin(angle) - 10,
//       );
//       textPainter.text = TextSpan(
//         text: notes[i],
//         style: const TextStyle(color: Colors.white, fontSize: 18),
//       );
//       textPainter.layout();
//       textPainter.paint(canvas, notePosition);
//     }

//     canvas.drawCircle(center, radius, paint);
//   }

//   @override
//   bool shouldRepaint(WheelPainter oldDelegate) => true;
// }
