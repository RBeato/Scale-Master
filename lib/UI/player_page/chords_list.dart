import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'metronome_indicator.dart';
import 'provider/selected_chords_provider.dart';

class ChordListWidget extends ConsumerStatefulWidget {
  @override
  _ChordListWidgetState createState() => _ChordListWidgetState();
}

class _ChordListWidgetState extends ConsumerState<ChordListWidget> {
  @override
  Widget build(BuildContext context) {
    final chordList = ref.watch(selectedChordsProvider);
    return SizedBox(
      height: 50, // Adjust height as needed
      child: chordList.isEmpty
          ? const Center(
              child: Text("No chords selected",
                  style: TextStyle(color: Colors.white)))
          : Stack(
              children: [
                const MetronomeIndicator(),
                Opacity(
                  opacity: 0.9,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final chord in chordList)
                        Expanded(
                          flex: chord.duration,
                          child: Container(
                            color: chord.color,
                            child: Center(
                              child: Text(
                                chord.chordNameForAudio!,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
    );
  }
}
