import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../constants/styles.dart';
import '../provider/settings_state_notifier.dart';
import 'chord_options_cards.dart';

class DrawerPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends ConsumerState<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: const <Widget>[
              ChordsOptions(),
            ],
          ),
          InkWell(
            highlightColor: cardColor,
            child: GestureDetector(
              onTap: () {
                ref.read(settingsStateNotifierProvider.notifier).resetValues();
              },
              child: Card(
                  color: clearPreferencesButtonColor,
                  child: const ListTile(
                    title: Text(
                      'Clear Preferences',
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
