import 'package:flutter/material.dart';

import '../../models/scale_model.dart';
import 'custom_piano_key.dart';

class CustomPiano extends StatefulWidget {
  const CustomPiano(this.scaleInfo, {required this.onKeyPressed, Key? key})
      : super(key: key);

  final ScaleModel? scaleInfo;
  final Function(String) onKeyPressed;

  @override
  State<CustomPiano> createState() => _CustomPianoState();
}

class _CustomPianoState extends State<CustomPiano> {
  final int numberOfOctaves = 7;
  final whiteKeyNotes = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];
  final blackKeyNotes = ['C♯/D♭', 'D♯/E♭', 'F♯/G♭', 'G♯/A♭', 'A♯/B♭'];

  @override
  Widget build(BuildContext context) {
    double whiteKeyWidth = 40.0;
    double blackKeyWidth = 25.0;
    double whiteKeysWidth = numberOfOctaves * 7 * whiteKeyWidth;

    // Calculate the initial scroll offset to center the piano
    double initialScrollOffset =
        (whiteKeysWidth - MediaQuery.of(context).size.width) / 2;

    // Create a ScrollController and set the initial scroll offset
    ScrollController scrollController =
        ScrollController(initialScrollOffset: initialScrollOffset);

    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 150,
        width: whiteKeysWidth,
        child: Stack(
          children: [
            Row(children: _buildWhiteKeys(whiteKeyWidth)),
            ..._buildBlackKeys(whiteKeyWidth, blackKeyWidth),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildWhiteKeys(double whiteKeyWidth) {
    List<Widget> whiteKeys = [];
    for (int octave = 0; octave < numberOfOctaves; octave++) {
      for (int i = 0; i < 7; i++) {
        String noteName = '${whiteKeyNotes[i]}${octave + 1}';
        whiteKeys.add(CustomPianoKey(
          isBlack: false,
          note: noteName,
          onKeyPressed: widget.onKeyPressed,
        ));
      }
    }
    return whiteKeys;
  }

  List<Widget> _buildBlackKeys(double whiteKeyWidth, double blackKeyWidth) {
    List<Widget> blackKeys = [];
    List<double> blackKeyOffsets = [
      whiteKeyWidth - blackKeyWidth / 2,
      whiteKeyWidth * 2 - blackKeyWidth / 2,
      whiteKeyWidth * 4 - blackKeyWidth / 2,
      whiteKeyWidth * 5 - blackKeyWidth / 2,
      whiteKeyWidth * 6 - blackKeyWidth / 2,
    ];

    for (int octave = 0; octave < numberOfOctaves; octave++) {
      for (int i = 0; i < blackKeyNotes.length; i++) {
        String noteName = blackKeyNotes[i] + (octave + 1).toString();
        double leftOffset = octave * 7 * whiteKeyWidth + blackKeyOffsets[i];

        blackKeys.add(Positioned(
          left: leftOffset,
          child: CustomPianoKey(
            isBlack: true,
            note: noteName,
            onKeyPressed: widget.onKeyPressed,
          ),
        ));
      }
    }
    return blackKeys;
  }
}
