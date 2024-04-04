import 'package:flutter/material.dart';
import '../../models/scale_model.dart';
import '../../utils/music_utils.dart';
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
  final int numberOfOctaves = 6;
  final whiteKeyNotes = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];
  final blackKeyNotes = ['C♯/D♭', 'D♯/E♭', 'F♯/G♭', 'G♯/A♭', 'A♯/B♭'];

  @override
  Widget build(BuildContext context) {
    double whiteKeyWidth = 40.0;
    double blackKeyWidth = 25.0;
    double whiteKeysWidth = numberOfOctaves * 7 * whiteKeyWidth;

    double initialScrollOffset =
        (whiteKeysWidth - MediaQuery.of(context).size.width) / 2;
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
        var notesList = widget.scaleInfo!.scaleNotesNames
            .map((e) => MusicUtils.extractNoteName(e))
            .toList();
        var t = MusicUtils.extractNoteName(
            MusicUtils.filterNoteNameWithSlash(noteName));

        Color? color = Colors.blue;
        // if (notesList.contains(t)) {
        notesList.first == t ? color = Colors.orange : color = Colors.blue;
        // print('Note is in scale');
        // int index = notesList.indexOf(t);
        // var degree = widget.scaleInfo!.degreeFunction[index];
        // color = ConstantColors.scaleColorMap[degree];
        // }
        whiteKeys.add(CustomPianoKey(
          isBlack: false,
          note: noteName,
          containerColor: color,
          onKeyPressed: widget.onKeyPressed,
          isInScale: _isInScale(noteName), // Check if note is in scale
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
        var notesList = widget.scaleInfo!.scaleNotesNames
            .map((e) => MusicUtils.extractNoteName(e))
            .toList();
        var t = MusicUtils.extractNoteName(
            MusicUtils.filterNoteNameWithSlash(noteName));
        String? degree;
        Color? color = Colors.blue;
        if (notesList.contains(t)) {
          // print('Note is in scale');
          // int index = notesList.indexOf(t);
          // degree = widget.scaleInfo!.degreeFunction[index];
          // color = ConstantColors.scaleColorMap[degree];
        }

        double leftOffset = octave * 7 * whiteKeyWidth + blackKeyOffsets[i];

        blackKeys.add(Positioned(
          left: leftOffset,
          child: CustomPianoKey(
            isBlack: true,
            note: noteName,
            containerColor: color,
            onKeyPressed: widget.onKeyPressed,
            isInScale: _isInScale(noteName), // Check if note is in scale
          ),
        ));
      }
    }
    return blackKeys;
  }

  // Check if the note is contained in the selected scale
  bool _isInScale(String noteName) {
    if (widget.scaleInfo != null) {
      List notesList = widget.scaleInfo!.scaleNotesNames
          .map((e) => MusicUtils.extractNoteName(e))
          .toList();
      if (noteName.contains('/')) {
        noteName = MusicUtils.filterNoteNameWithSlash(noteName);
      }
      String note = MusicUtils.extractNoteName(noteName);
      return notesList.contains(note);
    }
    return false;
  }
}
