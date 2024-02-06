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
    return SizedBox(
      width: 200.0,
      height: 100,
      child: Column(
        children: [
          // Display the list of chords with their durations
          Expanded(
            child: ListView.builder(
              itemCount: chordList.length,
              itemBuilder: (context, index) {
                final chord = chordList[index];
                return ListTile(
                  title: Text(chord.parentScaleKey),
                  trailing: SizedBox(
                    width: chord.duration == const Duration(seconds: 2)
                        ? 20.0
                        : 40.0,
                    child: LinearProgressIndicator(
                      value: 1.0, // Max progress for now
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(chord.color!),
                    ),
                  ),
                );
              },
            ),
          ),
          // Trash can button to clear the list
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                chordList.clear();
              });
            },
          ),
        ],
      ),
    );
  }
}
