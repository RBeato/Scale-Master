import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard_page/provider/fretboard_page_fingerings_provider.dart';
import 'package:scale_master_guitar/models/chord_scale_model.dart';

import '../fretboard/UI/fretboard_painter.dart';
import '../player_page/provider/player_page_title.dart';

class FretboardPage extends ConsumerWidget {
  const FretboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtain a copy of ChordScaleFingeringsModel specific to this page
    final fretboardFingerings = ref.watch(fretboardPageFingeringsProvider);

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: const PlayerPageTitle(),
        ),
        body: FretboardFull(fingeringsModel: fretboardFingerings),
      ),
    );
  }
}

class FretboardFull extends ConsumerWidget {
  final ChordScaleFingeringsModel fingeringsModel;

  const FretboardFull({Key? key, required this.fingeringsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int stringCount = 6;
    int fretCount = 24;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: RotatedBox(
        quarterTurns: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 50.0,
                ),
                child: RepaintBoundary(
                  child: GestureDetector(
                    onTapDown: (details) {
                      final tapPosition =
                          (context.findRenderObject() as RenderBox)
                              .globalToLocal(details.globalPosition);

                      final stringHeight = context.size!.height / stringCount;
                      final fretWidth = context.size!.width / fretCount;

                      final string = (tapPosition.dy / stringHeight).floor();
                      final fret = (tapPosition.dx / fretWidth).floor();

                      ref
                          .read(fretboardPageFingeringsProvider.notifier)
                          .addDot(string, fret);
                    },
                    onDoubleTap: () {
                      final tapPosition =
                          (context.findRenderObject() as RenderBox)
                              .globalToLocal(Offset.zero);

                      final stringHeight = context.size!.height / stringCount;
                      final fretWidth = context.size!.width / fretCount;

                      final string = (tapPosition.dy / stringHeight).floor();
                      final fret = (tapPosition.dx / fretWidth).floor();

                      ref
                          .read(fretboardPageFingeringsProvider.notifier)
                          .removeDot(string, fret);
                    },
                    child: CustomPaint(
                      painter: FretboardPainter(
                        stringCount: stringCount,
                        fretCount: fretCount,
                        fingeringsModel: fingeringsModel,
                      ),
                      child: SizedBox(
                        width: fretCount.toDouble() * 50,
                        height: stringCount.toDouble() * 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
