import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../fretboard/provider/beat_counter_provider.dart';

class GeneralProgressionTrack extends ConsumerWidget {
  const GeneralProgressionTrack(
      {required this.currentStep, required this.isBass});

  final int currentStep;
  final bool isBass;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberBeats = ref.watch(beatCounterProvider) as int;
    // final chords = ref.watch(selectedChordsProvider);
    // final selectedChords = getInstrumentChords(chords);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List<Widget>.generate(
        numberBeats,
        (i) => Expanded(
          child: SizedBox.expand(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: const Text("cell"),
            ),
          ),
        ),
      ),
    );
  }
}
