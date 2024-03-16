import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/chromatic_wheel/wheel_painter.dart';

import '../../constants/music_constants.dart';
import '../scale_selection_dropdowns/provider/mode_dropdown_value_provider.dart';
import '../scale_selection_dropdowns/provider/scale_dropdown_value_provider.dart';
import 'provider/top_note_provider.dart';

class ChromaticWheel extends ConsumerStatefulWidget {
  const ChromaticWheel(this.scaleDegrees, {Key? key}) : super(key: key);

  final List<String> scaleDegrees;

  @override
  _ChromaticWheelState createState() => _ChromaticWheelState();
}

class _ChromaticWheelState extends ConsumerState<ChromaticWheel> {
  double _currentRotation = 0.0;
  static const int numStops = 12;
  final double _rotationPerStop = 2 * math.pi / numStops;
  double _initialAngle = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialize your state if needed
  }

  void _updateRotation(double delta) {
    setState(() {
      _currentRotation += delta;
    });
  }

  String getTopNote() {
    // Adjust the angle calculation to accurately reflect the top of the wheel
    double topPositionAngle = (_currentRotation + math.pi / 2) % (2 * math.pi);
    if (topPositionAngle < 0) topPositionAngle += 2 * math.pi;

    // Determine the index of the note at this angle
    int noteIndex = (numStops -
            ((topPositionAngle / _rotationPerStop) % numStops).floor()) %
        numStops;

    return MusicConstants.notesWithFlatsAndSharps[noteIndex];
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(scaleDropdownValueProvider);
    ref.watch(modeDropdownValueProvider);
    return GestureDetector(
      onPanStart: (details) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset wheelCenter =
            renderBox.localToGlobal(renderBox.size.center(Offset.zero));
        _initialAngle = _angleFromCenter(details.globalPosition, wheelCenter);
      },
      onPanUpdate: (details) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset wheelCenter =
            renderBox.localToGlobal(renderBox.size.center(Offset.zero));
        final double currentAngle =
            _angleFromCenter(details.globalPosition, wheelCenter);
        _updateRotation(currentAngle - _initialAngle);
        _initialAngle =
            currentAngle; // Update the initial angle for continuous tracking
      },
      onPanEnd: (details) {
        var closestStop =
            ((_currentRotation + _rotationPerStop / 2) / _rotationPerStop)
                .floor();
        setState(() {
          _currentRotation = closestStop * _rotationPerStop;
        });
        String topNote = getTopNote();
        ref.read(topNoteProvider.notifier).update((state) => topNote);
      },
      child: CustomPaint(
        painter: WheelPainter(_currentRotation, widget.scaleDegrees),
        child: const SizedBox(width: 300, height: 300),
      ),
    );
  }

  double _angleFromCenter(Offset touchPosition, Offset wheelCenter) {
    return math.atan2(
        touchPosition.dy - wheelCenter.dy, touchPosition.dx - wheelCenter.dx);
  }
}
