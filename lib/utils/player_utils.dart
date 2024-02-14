import 'package:flutter_sequencer/models/instrument.dart';

import '../constants.dart';

class SoundPlayerUtils {
  static get instruments => [
        Sf2Instrument(
            path: Constants.soundPath['drums']!['Electronic'] as String,
            isAsset: true),
        Sf2Instrument(
            path: Constants.soundPath['keys']!['Rhodes'] as String,
            isAsset: true),
        Sf2Instrument(
            path: Constants.soundPath['bass']!['Double Bass'] as String,
            isAsset: true)
      ];
}
