import 'package:flutter/material.dart';

import '../../sizing_info.dart';
import '../service/get_fret_dot_dimentions.dart';
import 'fretboard_table_dots.dart';

class FretboardTable extends StatelessWidget {
  FretboardTable(this.cardSizeInfo);
  final SizingInformation cardSizeInfo;

  final int frets = 15;
  final int strings = 6 - 1;
  late Widget widget;
  Color borderColor = Colors.white38;
  final List rows = [0, 1, 2, 3, 4, 5];

  Map fretDimensions = {};

  _buildTable(int i, int j) {
    fretDimensions = getFretDotDimensions(cardSizeInfo);
    if (i == 0 && rows.contains(j)) borderColor = Colors.grey;
    return SizedBox(
      height: fretDimensions['height'],
      width: fretDimensions['width'],
      child: marksPositions.any((el) => (i == el[0] && j == el[1]))
          ? Container(
              decoration: const BoxDecoration(
              color: Colors.white10,
              shape: BoxShape.circle,
            ))
          : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    fretDimensions = getFretDotDimensions(cardSizeInfo);
    return Stack(
      children: [
        Positioned(
          child: Column(children: <Widget>[
            SizedBox(height: fretDimensions['height'] / 2),
            Table(
              border: TableBorder(
                left: BorderSide(
                    color: Colors.grey[800] as Color,
                    width: cardSizeInfo.localWidgetSize.width * 0.06),
                //controls fretboard nut width *** see fretboard_roman_numerals ***
                horizontalInside: BorderSide(color: borderColor, width: 1),
                verticalInside: BorderSide(color: borderColor, width: 1),
                top: BorderSide(color: borderColor, width: 1),
                bottom: BorderSide(color: borderColor, width: 1),
                right: BorderSide(color: borderColor, width: 1),
              ),
              children: [
                for (int i = 0; i < strings; i++)
                  TableRow(children: [
                    for (int j = 0; j < frets; j++) _buildTable(i, j)
                  ]),
              ],
            ),
          ]),
        ),
        Positioned(
          child: FretboardTableDots(
              dotHeight: fretDimensions['height'],
              dotWidth: fretDimensions['width']),
        ),
      ],
    );
  }

  List<List<int>> marksPositions = [
    [2, 3],
    [2, 5],
    [2, 7],
    [2, 9],
    [1, 12],
    [3, 12],
    [2, 15],
    [2, 17],
    [2, 19],
    [2, 21],
    [1, 24],
    [3, 24],
  ];
}
