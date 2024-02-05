import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'general_progression_track.dart';
import 'metronome_indicator.dart';
import 'sequencer_drum_parts.dart';

class Grid extends StatelessWidget {
  const Grid({
    Key? key,
    required this.getVelocity,
    required this.columnLabels,
    required this.stepCount,
    required this.currentStep,
    required this.onChange,
    required this.onNoteOn,
    required this.onNoteOff,
  });

  final Function(int step, int col) getVelocity;
  final List<String> columnLabels;
  final int stepCount;
  final int currentStep;
  final Function(int, int, double) onChange;
  final Function(int) onNoteOn;
  final Function(int) onNoteOff;

  @override
  Widget build(BuildContext context) {
    final int columnsCount = columnLabels.length;
    const double cellWidth = 20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        MetronomeIndicator(
          currentStep: currentStep,
          isBass: false,
        ),
        Column(
          children: [
            GeneralProgressionTrack(
              currentStep: currentStep,
              isBass: false,
            ),
            GeneralProgressionTrack(
              currentStep: currentStep,
              isBass: true,
            )
          ],
        ),
        SequencerDrumParts(
          stepCount: stepCount,
          columnsCount: columnsCount,
          getVelocity: getVelocity,
          cellWidth: cellWidth,
          currentStep: currentStep,
          onChange: onChange,
        )
      ],
    );
  }
}
