import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sequencer/track.dart';
import '../../models/step_sequencer_state.dart';
import 'chords_list.dart';

class DrumMachineWidget extends StatefulWidget {
  const DrumMachineWidget({
    Key? key,
    required this.selectedTempo,
    required this.handleChange,
    required this.track,
    required this.stepCount,
    required this.currentStep,
    required this.rowLabels,
    required this.columnPitches,
    required this.stepSequencerState,
    required this.handleVolumeChange,
    required this.handleVelocitiesChange,
  }) : super(key: key);

  final double selectedTempo;
  final Function(double nextTempo) handleChange;
  final Track track;
  final int stepCount;
  final int currentStep;
  final List<String> rowLabels;
  final List<int> columnPitches;
  final StepSequencerState stepSequencerState;
  final Function(double) handleVolumeChange;
  final Function(int, int, int, double) handleVelocitiesChange;

  @override
  _DrumMachineWidgetState createState() => _DrumMachineWidgetState();
}

class _DrumMachineWidgetState extends State<DrumMachineWidget>
    with SingleTickerProviderStateMixin {
  late Ticker ticker;

  @override
  void dispose() {
    super.dispose();
  }

  double getVelocity(int step, int col) {
    return widget.stepSequencerState
        .getVelocity(step, widget.columnPitches[col]);
  }

  void handleVelocityChange(int col, int step, double velocity) {
    widget.handleVelocitiesChange(
        widget.track.id, step, widget.columnPitches[col], velocity);
  }

  void handleNoteOn(int col) {
    widget.track
        .startNoteNow(noteNumber: widget.columnPitches[col], velocity: .75);
  }

  void handleNoteOff(int col) {
    widget.track.stopNoteNow(noteNumber: widget.columnPitches[col]);
  }

  @override
  Widget build(BuildContext context) {
    return ChordListWidget();
  }
}
