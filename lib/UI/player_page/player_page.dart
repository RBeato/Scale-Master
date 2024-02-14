import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/player_page/player_widget.dart';
import 'package:scale_master_guitar/UI/player_page/provider/selected_chords_provider.dart';

import '../chords/chords.dart';
import '../fretboard/UI/fretboard_neck.dart';

class PlayerPage extends ConsumerWidget {
  const PlayerPage({Key? key}) : super(key: key);

  Future<bool> popped() {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChords = ref.watch(selectedChordsProvider);
    return WillPopScope(
      onWillPop: () => popped(),
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: const Text("Play!"),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //FRETBOARD
              Fretboard(),
              //CHORDS
              const Expanded(flex: 1, child: Chords()),
              // //SELECTED CHORD LIST
              // Expanded(child: ChordListWidget()),
              //
              // SEQUENCER
              selectedChords.isEmpty
                  ? const Center(
                      child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("No chords selected",
                          style: TextStyle(color: Colors.white)),
                    ))
                  : const Expanded(flex: 4, child: PlayerWidget())
            ],
          ),
        ),
      ),
    );
  }
}
