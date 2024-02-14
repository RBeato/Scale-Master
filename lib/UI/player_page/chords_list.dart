import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/selected_chords_provider.dart';

class ChordListWidget extends ConsumerStatefulWidget {
  @override
  _ChordListWidgetState createState() => _ChordListWidgetState();
}

class _ChordListWidgetState extends ConsumerState<ChordListWidget> {
  @override
  Widget build(BuildContext context) {
    final chordList = ref.watch(selectedChordsProvider);
    return Wrap(
      alignment: WrapAlignment.start,
      children: chordList.map((chord) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: SizedBox(
            width: chord.duration == 2 ? 20.0 : 40.0,
            child: Container(
              color: chord.color,
              child: Text(
                chord.chordNameForAudio!,
                overflow: TextOverflow.clip,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
