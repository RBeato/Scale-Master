import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../hardcoded_data/fretboard_notes.dart';
import '../../../models/chord_scale_model.dart';
import '../provider/fingerings_provider.dart';

class FretboardTableDots extends ConsumerWidget {
  FretboardTableDots({required this.dotHeight, required this.dotWidth});
  final double dotHeight;
  final double dotWidth;

  final int frets = 15;
  final int strings = 6;
  static ChordScaleFingeringsModel? auxMap;
  late ChordScaleFingeringsModel selectedChordsAndBass;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: <Widget>[
      Consumer(builder: (context, watch, _) {
        var fingerings = ref.watch(chordModelFretboardFingeringProvider) as Map;

        if (fingerings.isNotEmpty) {
          selectedChordsAndBass = auxMap ?? fingerings[fingerings.keys.first];
        }
        return fingerings.isEmpty
            ? Container()
            : Table(
                children: [
                  for (int i = 0; i < strings; i++)
                    TableRow(children: [
                      for (int j = 0; j < frets; j++)
                        SizedBox(
                          height: dotHeight,
                          width: dotWidth,
                          child: Center(
                              child: Container(
                                  height: 1 / frets * dotHeight * 600, //*300
                                  width: 1 / frets * dotHeight * 600,
                                  decoration: BoxDecoration(
                                    color: createPositionColor(
                                        stringNumber: i,
                                        fretNumber: j,
                                        positionsInfo: selectedChordsAndBass),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: AutoSizeText(
                                    buildFretboardNotesNames(
                                      fingerings as Map<int,
                                          ChordScaleFingeringsModel>,
                                      i,
                                      j,
                                    ),
                                    minFontSize: 10.0,
                                    maxFontSize: 22.0,
                                    style: const TextStyle(fontSize: 20.0),
                                    maxLines: 1,
                                  )))),
                        ),
                    ]),
                ],
              );
      })
    ]);
  }

  buildFretboardNotesNames(
      Map<int, ChordScaleFingeringsModel> fingerings, int i, int j) {
    String noteName;
    ChordScaleFingeringsModel? noteInfo =
        auxMap ?? fingerings[fingerings.keys.first];

    // print("NOTE INFO:  $noteInfo");
    if (['C', 'D', 'E', 'F', 'G', 'A', 'B']
        .contains(noteInfo!.chordModel!.originKey)) {
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
