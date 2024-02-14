import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'cell.dart';

class SequencerDrumParts extends StatelessWidget {
  final Function getVelocity;
  final int stepCount;
  final int columnsCount;
  final double cellWidth;
  final Function onChange;
  final int currentStep;
  const SequencerDrumParts({
    required this.getVelocity,
    required this.cellWidth,
    required this.columnsCount,
    required this.onChange,
    required this.stepCount,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     Column(
      //       children: [
      //         _labelImage(
      //             image: Constants.samplesImages[2],
      //             color: Constants.colors[2].withOpacity(0.5),
      //             padding: 2.0),
      //         _labelImage(
      //             image: Constants.samplesImages[1],
      //             color: Constants.colors[1].withOpacity(0.5),
      //             padding: 5.0),
      //         _labelImage(
      //             image: Constants.samplesImages[0],
      //             color: Constants.colors[0].withOpacity(0.5),
      //             padding: 6.0),
      //         _labelImage(
      //             image: Constants.samplesImages[3],
      //             color: Constants.colors[3].withOpacity(0.5),
      //             padding: 7.0),
      //       ],
      //     ),
      //     Expanded(
      //       child: SizedBox(
      //         width: cellWidth * stepCount,
      //         child: ListView.builder(
      //             padding: const EdgeInsets.all(0.0),
      //             physics: const NeverScrollableScrollPhysics(),
      //             scrollDirection: Axis.horizontal,
      //             shrinkWrap: true,
      //             itemCount: stepCount,
      //             itemBuilder: (BuildContext context, int step) {
      //               final List<Widget> cellWidgets = [];

      //               for (var i = 0; i < columnsCount; i++) {
      //                 final velocity = getVelocity(step, i);

      //                 final cellWidget = Cell(
      //                   step: step,
      //                   instrument: i,
      //                   cellHeight: 30,
      //                   cellWidth: cellWidth,
      //                   velocity: velocity,
      //                   isCurrentStep: step == currentStep,
      //                   onChange: (velocity) => onChange(i, step, velocity),
      //                 );

      //                 cellWidgets.add(cellWidget);
      //               }
      //               return Column(children: cellWidgets);
      //             }),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget _labelImage({double? size, var image, double? padding}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
            bottom: BorderSide(
          color: Colors.transparent,
        ) //amber.withOpacity(0.4)),
            ),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding!),
        child: Image(
          image: AssetImage(image),
          // height: 8.0,
          // width: 8.0,
        ),
      ),
    );
  }
}
