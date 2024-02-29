import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/player_page/player/player_widget.dart';
import 'package:scale_master_guitar/UI/player_page/provider/selected_chords_provider.dart';

import '../chords/chords.dart';
import '../fretboard/UI/fretboard_neck.dart';
import 'draggable_handle.dart';

class PlayerPage extends ConsumerWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final chordList = ref.watch(selectedChordsProvider)
    return WillPopScope(
      onWillPop: () {
        ref.read(selectedChordsProvider.notifier).removeAll();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: const Text("Play!"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Fretboard(),
                  const Expanded(flex: 2, child: Chords()),
                  const Expanded(flex: 4, child: PlayerWidget()),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:
                    DraggableHandle(), // Use your draggable handle widget here
              ),
            ],
          ),
        ),
      ),
    );
  }
}
