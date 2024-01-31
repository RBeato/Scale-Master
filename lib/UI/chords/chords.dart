import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../fretboard/provider/fingerings_provider.dart';

class Chords extends ConsumerWidget {
  const Chords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int stringCount = 6;
    int fretCount = 24;
    // Access properties from chordScaleFingeringsModel and customize the appearance
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);

    // Use these properties to customize the dots or text within FretboardPainter
    return fingerings.when(
        data: (chordScaleFingeringsModel) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: chordScaleFingeringsModel!.chordModel!.chords!.map((c) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    width: 30, // Set a fixed width for all containers
                    height: 30, // Set a fixed height for all containers
                    child: GestureDetector(
                      onTap: () {
                        // Handle the onTap event here
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12, // Set the background color
                          borderRadius:
                              BorderRadius.circular(10), // Add rounded corners
                          border: Border.all(
                              color: Colors.white,
                              width: 2), // Add a white border
                        ),
                        child: Center(
                          child: Text(
                            c,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
        loading: () => const CircularProgressIndicator(color: Colors.orange),
        error: (error, stackTrace) => Text('Error: $error'));
  }
}
