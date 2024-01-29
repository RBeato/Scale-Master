import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../models/settings_model.dart';
import '../models/settings_state.dart';
import '../provider/settings_state_notifier.dart';
import 'build_loading.dart';
import 'drawer_card.dart';
import 'drawer_switch_general.dart';

class ChordsOptions extends ConsumerWidget {
  const ChordsOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, watch, _) {
        final state = ref.watch(settingsStateNotifierProvider);

        if (state is SettingsInitial) {
          return const Text("Didn't load chord Options!");
          // buildInitialSettingsInput(context);
        } else if (state is SettingsLoading) {
          return buildLoadingSettings();
        } else if (state is SettingsLoaded) {
          return ChordsOptionsCards(state.settings);
        } else if (state is SettingsError) {
          return const Text("Error loading chord Options!");
          // buildInitialSettingsInput(context);
        }
        return const Text("Didn't load chord Options!");
      },
    );
  }
}

class ChordsOptionsCards extends StatelessWidget {
  ChordsOptionsCards(this.settings);
  Settings settings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerGeneralSwitch(
          title: 'Scales + Chords',
          subtitle: 'If unselected will show scale tones with different colors',
          settings: settings,
        ),
        settings.scaleAndChordsOption == true
            ? Column(
                children: [
                  DrawerCard(
                    title: 'Chord Voicings',
                    subtitle: 'Choose the type of fingering for chords',
                    dropdownList: settings.chordVoicings,
                    savedValue: settings.chordVoicingOption,
                  ),
                  DrawerCard(
                      title: 'Bottom Note String',
                      subtitle:
                          'The lowest note where the chord fingerings are built upon',
                      dropdownList: settings.bottomNoteStringList,
                      savedValue: settings.bottomNoteStringOption),
                ],
              )
            : Container(),
      ],
    );
  }
}
