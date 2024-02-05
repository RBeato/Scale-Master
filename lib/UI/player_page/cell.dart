import 'package:flutter/material.dart';

import '../../constants.dart';

class Cell extends StatelessWidget {
  const Cell({
    Key? key,
    required this.step,
    required this.instrument,
    required this.velocity,
    required this.cellHeight,
    required this.cellWidth,
    required this.isCurrentStep,
    required this.onChange,
  }) : super(key: key);

  final int step;
  final int instrument;
  final double cellHeight;
  final double cellWidth;
  final double velocity;
  final bool isCurrentStep;
  final Function(double) onChange;

  @override
  Widget build(BuildContext context) {
    final box = SizedBox(
      height: cellHeight,
      width: cellWidth,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(cellHeight / 4),
            border:
                Border.all(color: Colors.white60.withOpacity(0.15), width: 1.0),
          ),
          child: Center(
              child: Text("${step + 1}",
                  style: TextStyle(
                      fontSize: 13 * cellWidth / cellHeight,
                      color: isCurrentStep
                          ? Colors.white10.withOpacity(0.6)
                          : Colors.white10.withOpacity(0.2)))),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        final nextVelocity = velocity == 0.0 ? Constants.DEFAULT_VELOCITY : 0.0;
        onChange(nextVelocity);
      },
      child: box,
    );
  }
}
