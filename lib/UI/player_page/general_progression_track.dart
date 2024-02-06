import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard/provider/beat_counter_provider.dart';

import '../../models/chord_model.dart';
import 'provider/selected_chords_provider.dart';

class GeneralProgressionTrack extends ConsumerWidget {
  const GeneralProgressionTrack(
      {required this.currentStep, required this.isBass});

  final int currentStep;
  final bool isBass;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InkWell(
            enableFeedback: false,
            child: SizedBox(
              width: 30,
              child: Center(
                child: Image(
                  image: AssetImage(isBass
                      ? 'assets/images/bass_guitar.png'
                      : 'assets/images/piano.png'),
                  height: 30,
                ),
              ),
            ),
          ),
          Expanded(child: Consumer(builder: (context, watch, _) {
            final numberBeats = ref.watch(beatCounterProvider) as int;
            final chords = ref.watch(selectedChordsProvider);
            final selectedChords =
                getInstrumentChords(chords as List<ChordModel>);
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                  width: 1.0,
                  color: Colors.transparent,
                )),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List<Widget>.generate(
                  numberBeats,
                  (i) => Expanded(
                    child: SizedBox.expand(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Text("cell"),
                      ),
                    ),
                  ),
                ),
              ),
            );
          })),
        ]);
  }

  getInstrumentChords(List<ChordModel> selectedChords) {
    List chords;
    if (isBass) {
      chords = selectedChords.where((chord) => chord.bassNote != null).toList();
    } else {
      chords = selectedChords.where((chord) => chord.bassNote == null).toList();
    }
    return chords;
  }
}
