import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard/UI/fretboard_painter.dart';

import '../provider/fingerings_provider.dart';

class Fretboard extends ConsumerWidget {
  Fretboard({Key? key}) : super(key: key);
  // Create a ScrollController
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int stringCount = 6;
    int fretCount = 24;
    // Access properties from chordScaleFingeringsModel and customize the appearance
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);

    // Use these properties to customize the dots or text within FretboardPainter
    return fingerings.when(
        data: (chordScaleFingeringsModel) {
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController, // Add the controller here
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: CustomPaint(
                  painter: FretboardPainter(
                    stringCount: stringCount,
                    fretCount: fretCount,
                    fingeringsModel: chordScaleFingeringsModel!,
                  ),
                  child: SizedBox(
                    width: fretCount.toDouble() * 36,
                    height: stringCount.toDouble() * 24,
                  ),
                ),
              ));
        },
        loading: () => const CircularProgressIndicator(color: Colors.orange),
        error: (error, stackTrace) => Text('Error: $error'));
  }
}
