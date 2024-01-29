import 'package:flutter/material.dart';

import '../../../sizing_info.dart';
import '../../service/get_fret_dot_dimensions.dart';
import 'fretboard_dot.dart';
import 'fretboard_neck.dart';

class Fretboard extends StatelessWidget {
  Fretboard(this.cardSizeInfo);
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
      child: Container(color: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    fretDimensions = getFretDotDimensions(cardSizeInfo);
    return Stack(
      children: const [
        FretboardNeck(stringCount: 6, fretCount: 24),
        FretboardDot(
          fretCount: 24,
          stringCount: 6,
        )
      ],
    );
  }
}
