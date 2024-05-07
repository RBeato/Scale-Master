import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard/provider/fingerings_provider.dart';
import 'package:scale_master_guitar/UI/fretboard_page/customizable_fretboard.dart';

import '../fretboard/UI/fretboard_neck.dart';
import '../player_page/provider/player_page_title.dart';

class FretboardPage extends StatefulWidget {
  const FretboardPage({super.key});

  @override
  State<FretboardPage> createState() => _FretboardPageState();
}

class _FretboardPageState extends State<FretboardPage> {
  @override
  Widget build(BuildContext context) {
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
            body: Transform.rotate(
                angle:
                    90 * 3.141592653589793 / 180, // Convert degrees to radians
                child: Fretboard())));
  }
}

class FretboardSecondWidget extends ConsumerWidget {
  const FretboardSecondWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int stringCount = 6;
    int fretCount = 24;
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);

    return SizedBox(
      height: 200,
      child: fingerings.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 50.0,
            ),
            child: FretboardCustomizablePainter(
              stringCount: stringCount,
              fretCount: fretCount,
              fingeringsModel: data!,
              onDotsUpdated: (dots) {
                // Do something with the dots
              },
            ),
          );
        },
        loading: () => const CircularProgressIndicator(color: Colors.orange),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }
}
