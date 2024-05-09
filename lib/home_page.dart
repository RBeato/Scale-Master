import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/chromatic_wheel/chromatic_wheel.dart';
import 'package:scale_master_guitar/UI/drawer/UI/drawer/custom_drawer.dart';

import 'UI/chromatic_wheel/provider/top_note_provider.dart';
import 'UI/custom_piano/custom_piano_player.dart';
import 'UI/fretboard/provider/fingerings_provider.dart';
import 'UI/player_page/player_page.dart';
import 'UI/scale_selection_dropdowns/scale_selection.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(topNoteProvider);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlayerPage()));
            },
            icon: const Icon(Icons.arrow_forward, color: Colors.orange),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 1, child: ScaleSelector()),
            const Expanded(
              flex: 8,
              child: WheelAndPianoColumn(),
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}

class WheelAndPianoColumn extends ConsumerWidget {
  const WheelAndPianoColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(topNoteProvider);
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);
    return fingerings.when(
        data: (data) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(child: ChromaticWheel(data!.scaleModel!)),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomPianoSoundController(data.scaleModel)),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.orange)),
        error: (error, stackTrace) => Text('Error: $error'));
  }
}
