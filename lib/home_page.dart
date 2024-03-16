import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/chromatic_wheel/chromatic_wheel.dart';
import 'package:scale_master_guitar/UI/drawer/UI/drawer/custom_drawer.dart';

import 'UI/custom_piano/custom_piano_player.dart';
import 'UI/drawer/provider/settings_state_notifier.dart';
import 'UI/fretboard/provider/fingerings_provider.dart';
import 'UI/player_page/player_page.dart';
import 'UI/scale_selection_dropdowns/scale_selection.dart';
import 'models/settings_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return settings.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) {
          return const Text('Error loading settings');
        },
        data: (settings) {
          return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              backgroundColor: Colors.grey[800],
              title: Text(widget.title),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayerPage(settings)));
                  },
                  icon: const Icon(Icons.arrow_forward, color: Colors.orange),
                ),
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  Expanded(flex: 2, child: ScaleSelector()),
                  Expanded(flex: 20, child: DropdownDependentWidgets(settings)),
                ],
              ),
            ),
            drawer: CustomDrawer(),
          );
        });
  }
}

class DropdownDependentWidgets extends ConsumerWidget {
  const DropdownDependentWidgets(this.settings, {super.key});
  final Settings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);
    return Center(
      child: fingerings.when(
          data: (chordScaleFingeringsModel) {
            print(
                'degrees: ${chordScaleFingeringsModel!.scaleModel!.degreeFunction}');
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                      child: ChromaticWheel(chordScaleFingeringsModel
                          .scaleModel!.degreeFunction)),
                  CustomPianoSoundController(
                      settings, chordScaleFingeringsModel.scaleModel),
                ]);
          },
          loading: () => const CircularProgressIndicator(color: Colors.orange),
          error: (error, stackTrace) => Text('Error: $error')),
    );
  }
}
