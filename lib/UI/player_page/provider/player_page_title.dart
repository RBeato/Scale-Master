import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../fretboard/provider/fingerings_provider.dart';

class PlayerPageTitle extends ConsumerWidget {
  const PlayerPageTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);

    return fingerings.when(
        data: (data) {
          return Text(
              "${data!.scaleModel!.parentScaleKey} ${data.scaleModel!.mode} - ${data.scaleModel!.scale}");
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'));
  }
}
