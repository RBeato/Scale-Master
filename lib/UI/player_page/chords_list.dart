import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'metronome_indicator.dart';
import 'provider/selected_chords_provider.dart';

class ChordListWidget extends ConsumerStatefulWidget {
  const ChordListWidget({super.key});

  @override
  _ChordListWidgetState createState() => _ChordListWidgetState();
}

class _ChordListWidgetState extends ConsumerState<ChordListWidget> {
  @override
  Widget build(BuildContext context) {
    final chordList = ref.watch(selectedChordsProvider);
    return Card(
      elevation: 4.0, // Optional: adds shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            15.0), // Adjust radius to get the desired corner roundness
      ),

      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: chordList.isEmpty
            ? const Center(
                child: Text("No chords selected",
                    style: TextStyle(color: Colors.white)))
            : SizedBox(
                height: 150, // Adjust height as needed for the entire widget
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
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
                                          chord.noteName,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Ensure this SizedBox or any child that needs specific sizing is properly constrained
                        ],
                      ),
                    ),
                    // SizedBox(height: 100, child: ExtensionsSelectionWidget()),
                    // Add more widgets here if needed, outside the Stack but inside the Column
                  ],
                ),
              ),
      ),
    );
  }
}
