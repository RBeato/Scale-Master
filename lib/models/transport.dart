import 'package:flutter/material.dart';

class Transport extends StatelessWidget {
  const Transport({
    Key? key,
    required this.isPlaying,
    required this.isLooping,
    required this.onTogglePlayPause,
    required this.onStop,
    required this.onToggleLoop,
  }) : super(key: key);

  final bool isPlaying;
  final bool isLooping;
  final Function() onTogglePlayPause;
  final Function() onStop;
  final Function() onToggleLoop;

  @override
  Widget build(BuildContext context) {
    double size = 10 * 10;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: onTogglePlayPause,
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white70, //.orange[500].withOpacity(0.8),
            size: size,
          ),
        ),
        GestureDetector(
          onTap: onStop,
          child: Icon(
            Icons.stop,
            color: Colors.white70, //Colors.orange[500].withOpacity(0.8),
            size: size,
          ),
        ),
        GestureDetector(
          onTap: onToggleLoop,
          child: Icon(
            Icons.loop,
            color: isLooping
                ? Colors.white70 //.orange[500].withOpacity(0.8)
                : Colors.black54,
            size: size,
          ),
        ),
      ],
    );
  }
}
