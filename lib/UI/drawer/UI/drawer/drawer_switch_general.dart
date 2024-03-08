import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:scale_master_guitar/UI/drawer/UI/drawer/settings_enum.dart';
import 'package:scale_master_guitar/UI/drawer/provider/settings_state_notifier.dart';
import 'package:scale_master_guitar/models/settings_model.dart';

class DrawerGeneralSwitch extends ConsumerWidget {
  const DrawerGeneralSwitch({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.settings,
    required this.settingSelection,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Settings settings;
  final SettingsSelection settingSelection;

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
        return true;

      default:
        return false;
    }
  }
}
