import 'package:flutter/material.dart';
import 'package:flutter_virtual_piano/flutter_virtual_piano.dart';

class PianoWidget extends StatefulWidget {
  const PianoWidget({super.key});

  @override
  State<PianoWidget> createState() => _PianoWidgetState();
}

class _PianoWidgetState extends State<PianoWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: VirtualPiano(
        noteRange: const RangeValues(61, 78),
        // noteRange: const RangeValues(60, 90),
        highlightedNoteSets: const [
          // HighlightedNoteSet({44, 55, 77, 32}, Colors.green),
          // HighlightedNoteSet({34, 45, 67, 32}, Colors.blue)
        ],
        onNotePressed: (note, pos) {
          print("note pressed $note pressed at $pos");
        },
        onNoteReleased: (note) {
          print("note released $note");
        },
        onNotePressSlide: (note, pos) {
          print("note slide $note pressed at $pos");
        },
        elevation: 0,
        showKeyLabels: true,
      ),
    );
  }
}
