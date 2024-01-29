import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../models/settings_model.dart';
import '../provider/settings_state_notifier.dart';

class DrawerGeneralSwitch extends ConsumerWidget {
  const DrawerGeneralSwitch({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.settings,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Settings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSwitched;
    return Card(
      color: Colors.black12,
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Switch(
          value: getBool(title, settings),
          onChanged: (value) {
            isSwitched = value;
            ref
                .read(settingsStateNotifierProvider.notifier)
                .changeValue(title, isSwitched);
            // if (title == "Harmonic Minor Harmony") {
            //   context.read(chordSuggestionProvider).cancelAnimation();
            // }
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Text(
                subtitle,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 11.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getBool(String title, Settings settings) {
    switch (title) {
      case 'Scales + Chords':
        return settings.scaleAndChordsOption;

      default:
        return false;
    }
  }
}
