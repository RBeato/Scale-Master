import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../sizing_info.dart';
import '../service/get_fret_dot_dimentions.dart';

class FretboardRomanNumerals extends StatelessWidget {
  FretboardRomanNumerals(this.cardSizeInfo);

  final SizingInformation cardSizeInfo;

  @override
  Widget build(BuildContext context) {
    int frets = 15;
    // int lines = 1;

    Map fretDimensions = {};
    fretDimensions = getFretDotDimensions(cardSizeInfo);

    return Column(children: <Widget>[
      Table(children: [
        TableRow(children: [
          for (int j = 0; j < frets; j++)
            SizedBox(
                height: fretDimensions['height'],
                width: fretDimensions['width'],
                child: appendRomanNumerals(j)),
        ]),
      ]),
    ]);
  }

  appendRomanNumerals(int fret) {
    String mark = '';
    switch (fret) {
      case 3:
        mark = 'III';
        break;
      case 5:
        mark = 'V';
        break;
      case 7:
        mark = 'VII';
        break;
      case 9:
        mark = 'IX';
        break;
      case 12:
        mark = 'XII';
        break;
      case 15:
        mark = 'XV';
        break;
      case 17:
        mark = 'XVII';
        break;
      case 19:
        mark = 'XIX';
        break;
      case 24:
        mark = 'XXIV';
        break;
      default:
    }
    return Center(
      child: AutoSizeText(
        mark,
        minFontSize: 9.0,
        maxFontSize: 15.0,
        style: TextStyle(
          fontSize: cardSizeInfo.localWidgetSize.height * 0.06,
          fontWeight: FontWeight.bold,
          color: Colors.orange[300]!.withOpacity(0.7),
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  final List<List<int>> marksPositions = [
    [2, 2],
    [2, 4],
    [2, 6],
    [2, 8],
    [1, 11],
    [3, 11],
    [2, 14],
    [2, 16],
    [2, 18],
    [2, 20],
    [1, 23],
    [3, 23],
  ];
}
