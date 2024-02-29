import 'package:flutter/material.dart';

import '../../models/scale_model.dart';
import 'custom_piano_key.dart';

class CustomPiano extends StatefulWidget {
  const CustomPiano(this.scaleInfo, {Key? key}) : super(key: key);

  final ScaleModel? scaleInfo;

  @override
  State<CustomPiano> createState() => _CustomPianoState();
}

class _CustomPianoState extends State<CustomPiano> {
  final int numberOfOctaves = 7;

  // Define a map of note names for white keys
  final whiteKeyNotes = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  // Define a map of note names for black keys
  final blackKeyNotes = ['C♯/D♭', 'D♯/E♭', 'F♯/G♭', 'G♯/A♭', 'A♯/B♭'];

  @override
  Widget build(BuildContext context) {
    double whiteKeyWidth = 40.0;
    double blackKeyWidth = 25.0;
    double whiteKeysWidth = numberOfOctaves * 7 * whiteKeyWidth;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 150, // The height to accommodate white and black keys
        width: whiteKeysWidth, // Width based on number of white keys
        child: Stack(
          children: [
            Row(
                children: _buildWhiteKeys(
                    whiteKeyWidth)), // Create white keys as a row
            ..._buildBlackKeys(whiteKeyWidth,
                blackKeyWidth), // Spread black keys into the stack
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
        ));
      }
    }
    return whiteKeys;
  }

  List<Widget> _buildBlackKeys(double whiteKeyWidth, double blackKeyWidth) {
    List<Widget> blackKeys = [];
    // Define the appropriate offsets for black keys within one octave
    List<double> blackKeyOffsets = [
      whiteKeyWidth - blackKeyWidth / 2,
      whiteKeyWidth * 2 - blackKeyWidth / 2,
      whiteKeyWidth * 4 - blackKeyWidth / 2,
      whiteKeyWidth * 5 - blackKeyWidth / 2,
      whiteKeyWidth * 6 - blackKeyWidth / 2,
    ];

    // Iterate over the number of octaves
    for (int octave = 0; octave < numberOfOctaves; octave++) {
      // Iterate over each black key note name within one octave
      for (int i = 0; i < blackKeyNotes.length; i++) {
        String noteName = blackKeyNotes[i] + (octave + 1).toString();
        // Calculate the left offset for each black key
        double leftOffset = octave * 7 * whiteKeyWidth + blackKeyOffsets[i];

        // Create the black key with the note name
        blackKeys.add(Positioned(
          left: leftOffset,
          child: CustomPianoKey(
            isBlack: true,
            note: noteName,
          ),
        ));
      }
    }
    return blackKeys;
  }
}
