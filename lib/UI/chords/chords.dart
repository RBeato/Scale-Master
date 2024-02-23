import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/player_page/provider/selected_chords_provider.dart';

import '../../models/chord_model.dart';
import '../../models/chord_scale_model.dart';
import '../../utils/music_utils.dart';
import '../fretboard/provider/fingerings_provider.dart';

enum Taps { single, double }

class Chords extends ConsumerWidget {
  const Chords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alreadySelectedChords = ref.watch(selectedChordsProvider);
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);

    return fingerings.when(
        data: (ChordScaleFingeringsModel? scaleFingerings) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: FittedBox(
                        child: Text(
                          "Select Chords: ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: scaleFingerings!.scaleModel!.scaleNotesNames
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
                                var chord = addChordModel(
                                    Taps.single,
                                    c,
                                    scaleFingerings,
                                    index,
                                    alreadySelectedChords);
                                ref
                                    .read(selectedChordsProvider.notifier)
                                    .addChord(chord);

                                //   final chordList =
                                //       ref.read(selectedChordsProvider);

                                //   int beats = calculateNumberBeats(chordList);

                                //   ref
                                //       .read(beatCounterProvider.notifier)
                                //       .update((state) => beats);
                              },
                              onDoubleTap: () {
                                var chord = addChordModel(
                                    Taps.double,
                                    c,
                                    scaleFingerings,
                                    index,
                                    alreadySelectedChords);
                                ref
                                    .read(selectedChordsProvider.notifier)
                                    .addChord(chord);

                                // final chordList =
                                //     ref.read(selectedChordsProvider);

                                // int beats = calculateNumberBeats(chordList);

                                // ref
                                //     .read(beatCounterProvider.notifier)
                                //     .update((state) => beats);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors
                                      .black12, // Set the background color
                                  borderRadius: BorderRadius.circular(
                                      10), // Add rounded corners
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
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const CircularProgressIndicator(color: Colors.orange),
        error: (error, stackTrace) => Text('Error: $error'));
  }

  calculateNumberBeats(List<ChordModel> chordList) {
    int count = 0;
    for (var chord in chordList) {
      count += chord.duration;
    }
    return count;
  }

  addChordModel(
      tap,
      String uiChordName,
      ChordScaleFingeringsModel scaleFingerings,
      index,
      List<ChordModel> alreadySelectedChords) {
    var chordNotes =
        MusicUtils.getChordInfo(uiChordName, scaleFingerings, index);

    bool isPedalNote = false;

    var position = alreadySelectedChords.isEmpty
        ? 0
        : alreadySelectedChords.last.position +
            alreadySelectedChords.last.duration;

    ChordModel? chord = ChordModel(
      id: position,
      noteName: scaleFingerings.scaleModel!.scaleNotesNames[index],
      bassNote: isPedalNote == false
          ? scaleFingerings.scaleModel!.parentScaleKey
          : scaleFingerings.scaleModel!.scaleNotesNames[index],
      duration: tap == Taps.single ? 2 : 4,
      mode: scaleFingerings.scaleModel!.mode!,
      position: position,
      chordNotesWithIndexesUnclean: chordNotes,
      chordFunction: scaleFingerings.scaleModel!.chordTypes[index],
      chordDegree: scaleFingerings.scaleModel!.degreeFunction[index],
      scale: scaleFingerings.scaleModel!.scale!,
      originalScaleType: scaleFingerings.scaleModel!.scale!,
      parentScaleKey: scaleFingerings.scaleModel!.parentScaleKey,
    );

    return chord;
  }
}
