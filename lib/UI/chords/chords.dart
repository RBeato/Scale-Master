import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../hardcoded_data/scales/scales_data_v2.dart';
import '../../models/chord_model.dart';
import '../fretboard/provider/fingerings_provider.dart';
import '../player_page/provider/selected_chords_provider.dart';

enum Taps { single, double }

class Chords extends ConsumerWidget {
  const Chords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access properties from chordScaleFingeringsModel and customize the appearance
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);

    // Use these properties to customize the dots or text within FretboardPainter
    return fingerings.when(
        data: (chordScaleFingeringsModel) {
          final chordList = ref.watch(selectedChordsProvider);
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: chordScaleFingeringsModel!.chordModel!.chords!
                  .asMap()
                  .entries
                  .map((entry) {
                final index = entry.key;
                final c = entry.value;
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    width: 35, // Set a fixed width for all containers
                    height: 35, // Set a fixed height for all containers
                    child: GestureDetector(
                      onTap: () {
                        getChordInfo(Taps.single, c, chordList, index);
                      },
                      onDoubleTap: () {
                        getChordInfo(Taps.double, c, chordList, index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12, // Set the background color
                          borderRadius:
                              BorderRadius.circular(10), // Add rounded corners
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ), // Add a white border
                        ),
                        child: Center(
                          child: Text(
                            c,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
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

  getChordInfo(Taps tap, String c, chordList, int index) {
    ChordModel? chord;

//Notes for audio (must be with flats)
//get degree from scale
//get name
//get function
//get type
//get notes indexes and pitches names into one map.

    var selectedChord = chordList[index];

    var type = Scales.data[selectedChord.scale][selectedChord.mode]['chordType']
        [index];

    var chordFunction =
        Scales.data[selectedChord.scale][selectedChord.mode]['function'][index];
    var chordIntervals =
        Scales.data[selectedChord.scale][selectedChord.mode]['intervals'];

    var auxIntervals = {
      '1': null,
      '3': null,
      '5': null,
      '7': null,
      '9': null,
      '11': null,
      '13': null,
    };
    var auxDisplacementValue = chordIntervals[index];

    for (var key in auxIntervals.keys) {
      if (int.tryParse(key)! % 2 == 0) {
        // Skip keys that are even
        continue;
      }

      auxIntervals[key] = chordIntervals[key] - auxDisplacementValue;
    }

    print("auxIntervals: $auxIntervals");

    // if (tap == Taps.single) {
    //   chord = chordList[c].copyWith(
    //     notes: ,

    //       duration: 1,
    //       position: chordList.isEmpty
    //           ? 1
    //           : chordList.last.position + chordList.last.duration + 2);
    // } else {
    //   chord =  ChordModel(
    //       chordModel: c,
    //       duration: 2,
    //       position: chordList.isEmpty
    //           ? 1
    //           : chordList.last.position + chordList.last.duration + 4);
    // }

    // chordList.addChord(ChordModel(
    //     chordModel: c,
    //     duration: 2,
    //     position: chordList.isEmpty
    //         ? 1
    //         : chordList.last.position + chordList.last.duration + 2));
  }
}
