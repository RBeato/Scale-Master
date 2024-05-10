// import 'package:flutter/material.dart';

// class FretboardCustomPainter extends StatefulWidget {
//   final int stringCount;
//   final int fretCount;
//   final double fretboardLengthRatio;
//   final List<Offset> dots;
//   final Function(List<Offset>) onDotsUpdated;

//   const FretboardCustomPainter({
//     required this.stringCount,
//     required this.fretCount,
//     required this.fretboardLengthRatio,
//     required this.dots,
//     required this.onDotsUpdated,
//   });

//   @override
//   _FretboardCustomPainterState createState() => _FretboardCustomPainterState();
// }

// class _FretboardCustomPainterState extends State<FretboardCustomPainter> {
//   late double fretWidth;
//   late double stringHeight;
//   late double dotRadius;

//   @override
//   void initState() {
//     super.initState();
//     final size = context.size!;
//     fretWidth = size.height / (widget.fretCount + 1);
//     stringHeight = size.width / widget.stringCount;
//     dotRadius = fretWidth / 3;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (details) {
//         if (widget.dots.isNotEmpty) {
//           final dotToRemove = widget.dots
//               .indexWhere((dot) => _isWithinDot(details.localPosition, dot));
//           if (dotToRemove != -1) {
//             setState(() {
//               widget.dots.removeAt(dotToRemove);
//               widget.onDotsUpdated(widget.dots);
//             });
//             return;
//           }
//         }
//         final dotToAdd = _calculateNearestDot(details.localPosition);
//         setState(() {
//           widget.dots.add(dotToAdd);
//           widget.onDotsUpdated(widget.dots);
//         });
//       },
//       child: CustomPaint(
//         painter: _FretboardPainter(
//           stringCount: widget.stringCount,
//           fretCount: widget.fretCount,
//           fretboardLengthRatio: widget.fretboardLengthRatio,
//           dots: widget.dots,
//           fretWidth: fretWidth,
//           stringHeight: stringHeight,
//           dotRadius: dotRadius,
//         ),
//       ),
//     );
//   }

//   Offset _calculateNearestDot(Offset position) {
//     final fret = (position.dy / fretWidth).round();
//     final string = (position.dx / stringHeight).round();
//     final nearestFretX = fretWidth * fret;
//     final nearestStringY = stringHeight * string;
//     return Offset(nearestStringY, nearestFretX);
//   }

//   bool _isWithinDot(Offset position, Offset dot) {
//     final distance = (position - dot).distance;
//     return distance <= dotRadius;
//   }
// }

// class _FretboardPainter extends CustomPainter {
//   final int stringCount;
//   final int fretCount;
//   final double fretboardLengthRatio;
//   final List<Offset> dots;
//   final double fretWidth;
//   final double stringHeight;
//   final double dotRadius;

//   _FretboardPainter({
//     required this.stringCount,
//     required this.fretCount,
//     required this.fretboardLengthRatio,
//     required this.dots,
//     required this.fretWidth,
//     required this.stringHeight,
//     required this.dotRadius,
//   });

//   static final Paint neckPaint = Paint()
//     ..color = Colors.grey[700]!
//     ..strokeWidth = 2.0;

//   static const TextStyle textStyle =
//       TextStyle(fontSize: 10.0, color: Colors.white);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final fretboardLength = size.height * fretboardLengthRatio;

//     // Draw vertical fret lines
//     for (int i = 0; i < fretCount + 1; i++) {
//       final x = i * fretWidth;
//       canvas.drawLine(
//         Offset(x, 0),
//         Offset(x, fretboardLength),
//         neckPaint,
//       );
//     }

//     // Draw horizontal string lines
//     for (int i = 0; i < stringCount; i++) {
//       final y = i * stringHeight;
//       canvas.drawLine(
//         Offset(0, y),
//         Offset(size.width, y),
//         neckPaint,
//       );
//     }

//     // Draw dots
//     for (final dot in dots) {
//       canvas.drawCircle(dot, dotRadius, neckPaint);
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
