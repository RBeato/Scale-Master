import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard_page/custom_fretboard_painter.dart';
import 'package:scale_master_guitar/UI/fretboard_page/provider/fretboard_page_fingerings_provider.dart';
import 'package:scale_master_guitar/UI/fretboard_page/widget_to_png.dart';
import 'package:scale_master_guitar/models/chord_scale_model.dart';

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
        body: Stack(
          children: [
            // const Align(
            //     alignment: Alignment.topRight, child: SaveImageButton()),
            FretboardFull(fingeringsModel: fretboardFingerings),
          ],
        ),
      ),
    );
  }
}

class FretboardFull extends ConsumerStatefulWidget {
  final ChordScaleFingeringsModel fingeringsModel;

  const FretboardFull({Key? key, required this.fingeringsModel})
      : super(key: key);

  @override
  ConsumerState<FretboardFull> createState() => _FretboardFullState();
}

class _FretboardFullState extends ConsumerState<FretboardFull> {
  late List<List<bool>> dotPositions;

  @override
  void initState() {
    super.initState();
    dotPositions = createDotPositions(widget.fingeringsModel);
  }

  List<List<bool>> createDotPositions(
      ChordScaleFingeringsModel fingeringsModel) {
    // Initialize an empty list of lists to represent the fretboard
    int stringCount = 6; // Assuming 6 strings on the fretboard
    int fretCount = 24; // Assuming 24 frets on the fretboard
    List<List<bool>> dotPositions = List.generate(
        stringCount, (index) => List.generate(fretCount + 1, (j) => false));

    // If scaleNotesPositions is available, iterate and mark those positions as true
    if (fingeringsModel.scaleNotesPositions != null) {
      for (final position in fingeringsModel.scaleNotesPositions!) {
        int string = position[0] - 1;
        int fret = position[1];

        // Ensure the position is within fretboard bounds
        if (string >= 0 &&
            string < stringCount &&
            fret >= 0 &&
            fret <= fretCount) {
          dotPositions[string][fret] = true;
        }
      }
    }

    return dotPositions;
  }

  @override
  Widget build(BuildContext context) {
    int stringCount = 6;
    int fretCount = 24;

    return Container(
      alignment: const Alignment(0.5, 0.5),
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.height * 0.5,
      child: RotatedBox(
        quarterTurns: 1,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 50.0,
                ),
                child: GestureDetector(
                  onTapDown: (details) {
                    final tapPosition = details.localPosition;

                    final stringHeight =
                        constraints.maxWidth * 0.39 / stringCount;
                    final fretWidth = constraints.maxHeight * 3.5 / fretCount;

                    final string = (tapPosition.dy / stringHeight).floor();
                    final fret = ((tapPosition.dx) / fretWidth).floor();
                    print("String: $string, fret: $fret");

                    // Create a copy of dotPositions to avoid mutating the original list
                    List<List<bool>> updatedDotPositions =
                        List.from(dotPositions);

                    // Toggle the dot presence at the tapped position
                    updatedDotPositions[string][fret] =
                        !updatedDotPositions[string][fret];

                    // Update the state using a provider (assuming you use Riverpod)
                    ref
                        .read(fretboardPageDotsProvider.notifier)
                        .update((state) => updatedDotPositions);
                  },
                  child: WidgetToPngExporter(
                    child: CustomPaint(
                      painter: CustomFretboardPainter(
                        stringCount: stringCount,
                        fretCount: fretCount,
                        fingeringsModel: widget.fingeringsModel,
                        dotPositions: dotPositions,
                      ),
                      child: SizedBox(
                        width: fretCount.toDouble() * 50,
                        height: stringCount.toDouble() * 40,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
