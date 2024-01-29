import 'package:flutter/material.dart';
import 'package:scale_master_guitar/UI/base_widget.dart';

import '../../sizing_info.dart';
import 'new_fretboard/fretboard.dart';
import 'fretboard_roman_numerals.dart';

class FretboardCard extends StatelessWidget {
  const FretboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: Container(
                    constraints: BoxConstraints(
                      maxHeight: _calculateMaxHeight(sizingInformation),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              sizingInformation.localWidgetSize.width * 0.025),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // FretboardTable(sizingInformation),
                          Fretboard(sizingInformation),
                          FretboardRomanNumerals(sizingInformation),
                        ],
                      ),
                    )))
          ]);
    });
  }
}

double _calculateMaxHeight(SizingInformation sizingInformation) {
  if (sizingInformation.orientation == Orientation.portrait) {
    return sizingInformation.localWidgetSize.width * 0.4;
  } else if (sizingInformation.orientation == Orientation.landscape &&
      sizingInformation.localWidgetSize.width > 570) {
    return sizingInformation.localWidgetSize.width * 0.45;
  } else {
    return sizingInformation.localWidgetSize.width * 0.30;
  }
}
