import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../custom_piano/custom_piano_player.dart';
import '../fretboard/provider/fingerings_provider.dart';

class PianoWidget extends ConsumerWidget {
  const PianoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);
    return Center(
      child: fingerings.when(
          data: (chordScaleFingeringsModel) {
            return CustomPianoSoundController(
                chordScaleFingeringsModel!.scaleModel);
          },
          loading: () => const CircularProgressIndicator(color: Colors.orange),
          error: (error, stackTrace) => Text('Error: $error')),
    );
  }
}
