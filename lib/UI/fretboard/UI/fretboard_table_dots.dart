import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard/provider/fingerings_provider.dart';

import '../../../hardcoded_data/fretboard_notes.dart';
import '../../../models/chord_scale_model.dart';

class FretboardTableDots extends ConsumerWidget {
  const FretboardTableDots({required this.dotHeight, required this.dotWidth});
  final double dotHeight;
  final double dotWidth;

  final int frets = 15;
  final int strings = 6;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);
    return fingerings.when(
      data: (data) => Column(
        children: [
          SizedBox(
              width: 400,
              height: 200,
              // color: Colors.green,
              child: ListView.builder(
                itemCount: strings,
                itemBuilder: (context, stringIndex) {
                  return Row(
                    children: List.generate(frets, (fretIndex) {
                      return SizedBox(
                        height: dotHeight,
                        width: dotWidth,
                        child: Center(
                          child: Container(
                            height: 1 / frets * dotHeight * 600, //*300
                            width: 1 / frets * dotHeight * 600,
                            decoration: BoxDecoration(
                              color: createPositionColor(
                                stringNumber: stringIndex,
                                fretNumber: fretIndex,
                                positionsInfo: data,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: AutoSizeText(
                                buildFretboardNotesNames(
                                  data!,
                                  stringIndex,
                                  fretIndex,
                                ),
                                minFontSize: 10.0,
                                maxFontSize: 22.0,
                                style: const TextStyle(fontSize: 20.0),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              )

              // Table(
              //   children: [
              //     for (int i = 0; i < strings; i++)
              //       TableRow(children: [
              //         for (int j = 0; j < frets; j++)
              //           SizedBox(
              //             height: dotHeight,
              //             width: dotWidth,
              //             child: Center(
              //                 child: Container(
              //                     height: 1 / frets * dotHeight * 600, //*300
              //                     width: 1 / frets * dotHeight * 600,
              //                     decoration: BoxDecoration(
              //                       color: createPositionColor(
              //                           stringNumber: i,
              //                           fretNumber: j,
              //                           positionsInfo: data),
              //                       shape: BoxShape.circle,
              //                     ),
              //                     child: Center(
              //                         child: AutoSizeText(
              //                       buildFretboardNotesNames(
              //                         data!,
              //                         i,
              //                         j,
              //                       ),
              //                       minFontSize: 10.0,
              //                       maxFontSize: 22.0,
              //                       style: const TextStyle(fontSize: 20.0),
              //                       maxLines: 1,
              //                     )))),
              //           ),
              //       ]),
              //   ],
              // ),
              ),
        ],
      ),
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () => const CircularProgressIndicator(),
    );
  }

  buildFretboardNotesNames(ChordScaleFingeringsModel fingerings, int i, int j) {
    String noteName;

    // print("NOTE INFO:  $noteInfo");
    if (['C', 'D', 'E', 'F', 'G', 'A', 'B']
        .contains(fingerings.chordModel!.parentScaleKey)) {
      noteName = fretboardNotesNamesSharps[i][j];
    } else {
      noteName = fretboardNotesNamesFlats[i][j];
    }
    return noteName;
  }

  createPositionColor({
    required int stringNumber,
    required int fretNumber,
    ChordScaleFingeringsModel? positionsInfo,
  }) {
    if (positionsInfo != null) {
      List chordPositions = positionsInfo.chordVoicingNotesPositions as List;
      List scalesPositions = positionsInfo.scaleNotesPositions as List;
      Map colorfulPosition = positionsInfo.scaleColorfulMap as Map;

      stringNumber = stringNumber + 1;
      Color? color;
      if (chordPositions.isEmpty) {
        return colorfulPosition["$stringNumber,$fretNumber"];
      } else {
        for (int i = 0; i < scalesPositions.length; i++) {
          for (int j = 0; j < chordPositions.length; j++) {
            if (chordPositions[j][0] == stringNumber &&
                chordPositions[j][1] == fretNumber) {
              if (fretNumber == 0) {
                color = Colors.greenAccent[100];
              } else {
                color = Colors.greenAccent;
              }

              break;
            }
            if (scalesPositions[i][0] == stringNumber &&
                scalesPositions[i][1] == fretNumber) {
              if (fretNumber == 0) {
                color = Colors.blueGrey;
              } else {
                color = Colors.blue[300];
              }
            }
          }
        }
      }
      return color;
    }
  }
}
