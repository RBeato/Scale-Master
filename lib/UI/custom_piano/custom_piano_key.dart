import 'package:flutter/material.dart';

class CustomPianoKey extends StatefulWidget {
  final bool isBlack;
  final String note;

  const CustomPianoKey({
    Key? key,
    required this.isBlack,
    required this.note,
  }) : super(key: key);

  @override
  State<CustomPianoKey> createState() => _CustomPianoKeyState();
}

class _CustomPianoKeyState extends State<CustomPianoKey> {
  bool _isPressed = false;

  void _onKeyTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onKeyTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isBlack ? Colors.black : Colors.white;
    final pressedColor = widget.isBlack ? Colors.black87 : Colors.white60;
    const textColor = Colors.grey;

    return GestureDetector(
      onTapDown: _onKeyTapDown,
      onTapUp: _onKeyTapUp,
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: _isPressed ? pressedColor : color,
          boxShadow: _isPressed
              ? null
              : [
                  const BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 2.0,
                  ),
                ],
          border: widget.isBlack
              ? null
              : Border(
                  right: BorderSide(width: 1.0, color: Colors.grey.shade800),
                ),
        ),
        height: widget.isBlack ? 100 : 150,
        width: widget.isBlack ? 25 : 40,
        alignment: Alignment.bottomCenter,
        child: Text(
          widget.note,
          textAlign: TextAlign.center,
          style: const TextStyle(color: textColor, fontSize: 12),
        ),
      ),
    );
  }
}
