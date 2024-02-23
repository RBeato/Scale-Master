import 'package:flutter/material.dart';

import 'metrome_custom_painter.dart';

class MetronomeButton extends StatefulWidget {
  @override
  _MetronomeButtonState createState() => _MetronomeButtonState();
}

class _MetronomeButtonState extends State<MetronomeButton> {
  bool _isOn = false;

  void _toggleMetronome() {
    setState(() {
      _isOn = !_isOn;
    });
    // Perform any other actions you need when toggling the metronome
    if (_isOn) {
      // Metronome is turned on, perform actions accordingly
    } else {
      // Metronome is turned off, perform actions accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: MetronomeIcon(
        isOn: _isOn,
        size: 32.0,
      ),
      // Set the icon color based on the metronome state
      color: _isOn ? Colors.greenAccent : Colors.grey,
      onPressed: _toggleMetronome,
    );
  }
}

class MetronomeIcon extends StatelessWidget {
  final double size;
  final bool isOn;

  const MetronomeIcon({Key? key, required this.size, required this.isOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: MetronomePainter(isOn: isOn),
    );
  }
}
