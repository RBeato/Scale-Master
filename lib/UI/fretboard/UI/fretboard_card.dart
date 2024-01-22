import 'package:flutter/material.dart';
import 'package:scale_master_guitar/UI/base_widget.dart';

import 'fretboard_roman_numerals.dart';
import 'fretboard_table.dart';

class FretboardCard extends StatelessWidget {
  const FretboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Center(child: ScaleInformation()),
          Center(
            child: Container(
              // color: Colors.green.withOpacity(0.3),
              constraints: BoxConstraints(
                  maxHeight:
                      sizingInformation.orientation == Orientation.portrait
                          ? sizingInformation.localWidgetSize.width * 0.4
                          : sizingInformation.orientation ==
                                      Orientation.landscape &&
                                  sizingInformation.localWidgetSize.width > 570
                              ? sizingInformation.localWidgetSize.width * 0.45
                              : sizingInformation.localWidgetSize.width * 0.30),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        sizingInformation.localWidgetSize.width * 0.025),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FretboardTable(sizingInformation),
                    FretboardRomanNumerals(sizingInformation),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
