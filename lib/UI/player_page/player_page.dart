import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard/provider/fingerings_provider.dart';

import 'package:scale_master_guitar/UI/player_page/player/player_widget.dart';
import 'package:scale_master_guitar/UI/player_page/provider/player_page_title.dart';
import 'package:scale_master_guitar/UI/player_page/provider/selected_chords_provider.dart';

import '../../models/chord_scale_model.dart';
import '../chords/chords.dart';
import '../fretboard/UI/fretboard_neck.dart';
import '../fretboard_page/fretboard_page.dart';
import '../fretboard_page/provider/fretboard_page_fingerings_provider.dart';

class PlayerPage extends ConsumerWidget {
  PlayerPage({Key? key}) : super(key: key);

  ChordScaleFingeringsModel? f;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);
    return WillPopScope(
      onWillPop: () {
        ref.read(selectedChordsProvider.notifier).removeAll();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: const PlayerPageTitle(),
          actions: [
            IconButton(
              onPressed: () {
                if (f != null) {
                  ref.read(fretboardPageFingeringsProvider.notifier).update(f!);
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FretboardPage()));
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
        body: SafeArea(
            child: fingerings.when(
                data: (data) {
                  f = data;
                  return Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(height: 30),
                          Fretboard(),
                          const Expanded(
                              flex: 6, child: Center(child: Chords())),
                          Expanded(
                              flex: 8,
                              child: PlayerWidget(data!.scaleModel!.settings!)),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ],
                  );
                },
                loading: () =>
                    const CircularProgressIndicator(color: Colors.orange),
                error: (error, stackTrace) => Text('Error: $error'))),
      ),
    );
  }
}
