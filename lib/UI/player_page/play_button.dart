import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/player_page/player_page.dart';

import '../../models/selected_item.dart';
import '../../models/settings_model.dart';
import '../sizing_info.dart';
import 'logic/bass_sounds.dart';
import 'logic/chords_sounds_creator.dart';

class BuildFloatingButton extends ConsumerStatefulWidget {
  const BuildFloatingButton(this.settings, this.sizingInfo);

  final Settings settings;
  final SizingInformation sizingInfo;

  @override
  ConsumerState<BuildFloatingButton> createState() =>
      _BuildFloatingButtonState();
}

class _BuildFloatingButtonState extends ConsumerState<BuildFloatingButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ChordSounds chordSounds = ChordSounds();
    BassSounds bassSounds = BassSounds();

    return Consumer(builder: (context, watch, _) {
      final selectedPositions =
          ref.watch(selectedItemsProvider) as List<SelectedItem>?;
      final selectedChordsListLength =
          ref.watch(selectedItemsProvider) as List<SelectedItem>? ??
              [].where((item) => item.isBass != true).toList().length;
      return Opacity(
        opacity: 0.8,
        child: FloatingActionButton(
          elevation: 15.0,
          splashColor: Colors.orange[500],
          onPressed: () {
            if (selectedChordsListLength == 0) {
              final snackBar = SnackBar(
                content: Text(
                  'No chords added!\nPlease drag and drop some chords to the chord template.',
                  style: TextStyle(
                    color: Colors.orange[100],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                duration: const Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              List<SelectedItem> selectedBassNotes =
                  bassSounds.createSoundLists((selectedPositions ?? [])
                          .where((item) => item.isBass == true)
                          .toList()) ??
                      [];

              List<SelectedItem> selectedChords = chordSounds.createSoundLists(
                      (selectedPositions ?? [])
                          .where((item) => item.isBass != true)
                          .toList()) ??
                  [];

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PlayerPage()));
            }
          },
          backgroundColor: Colors.orangeAccent,
          child: const Icon(
            Icons.music_note,
            color: Colors.white,
            size: 33.0,
          ),
        ),
      );
    });
  }
}
