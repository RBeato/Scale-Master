import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/chord_scale_model.dart';
import '../provider/beat_counter_provider.dart';
import '../provider/fingerings_provider.dart';

class ScaleInformation extends ConsumerWidget {
  ScaleInformation();

  static ChordScaleFingeringsModel? auxMap;
  late ChordScaleFingeringsModel selectedChordsAndBass;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int step = ref.watch(currentBeatProvider);
    var fingerings = ref.watch(chordModelFretboardFingeringProvider) as Map;

    if (fingerings[step] != null) auxMap = fingerings[step];
    if (fingerings.isNotEmpty) {
      selectedChordsAndBass = auxMap ?? fingerings[fingerings.keys.first];
    }

    return fingerings.isEmpty
        ? const Center(
            child: Text('Go back and add some chords! \nOr use the drums!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white38)))
        : Center(
            child: Text(
                '${selectedChordsAndBass.chordModel!.chordNameForUI} ${selectedChordsAndBass.chordModel!.originModeType}',
                style: const TextStyle(color: Colors.white70, fontSize: 22)),
          );
  }

  portraitInfoText({key, value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: AutoSizeText(
            key,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        AutoSizeText(
          value,
          maxFontSize: 18.0,
          minFontSize: 10.0,
          maxLines: value.contains(RegExp(r' ', caseSensitive: false)) ? 2 : 1,
          style: TextStyle(
            color: Colors.orange[200],
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
