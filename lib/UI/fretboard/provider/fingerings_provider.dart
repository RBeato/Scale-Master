import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../hardcoded_data/flats_and_sharps_to_flats_converter.dart';
import '../../../models/chord_model.dart';
import '../../../models/chord_scale_model.dart';
import '../../../models/settings_model.dart';
import '../../../utils/music_utils.dart';
import '../../drawer/provider/settings_state_notifier.dart';
import '../../chromatic_wheel/provider/top_note_provider.dart';
import '../../scale_selection/provider/mode_dropdown_value_provider.dart';
import '../../scale_selection/provider/scale_dropdown_value_provider.dart';
import '../service/fingerings_positions_and_color.dart';

final chordModelFretboardFingeringProvider =
    FutureProvider.autoDispose<ChordScaleFingeringsModel?>((ref) async {
  final topNote = ref.watch(topNoteProvider);
  final scale = ref.watch(scaleDropdownValueProvider);
  final mode = ref.watch(modeDropdownValueProvider);

  final settings = await ref.watch(settingsProvider.future);

  print("settings : ${settings.musicKey}");

  final chords =
      MusicUtils.createChords(settings, flatsAndSharpsToFlats(topNote), scale);

  ChordModel item = ChordModel(
    parentScaleKey: topNote,
    scale: 'Diatonic Major',
    mode: mode,
    chords: chords,
    chordProgression: scale,
    settings: settings,
  );

  var fingering = FingeringsColorBloc().createChordsScales(item, settings);

  return fingering;
});

class ChordModelFretboardFingeringsProvider
    extends StateNotifier<Map<int, ChordScaleFingeringsModel>> {
  ChordModelFretboardFingeringsProvider({
    fingerings,
  }) : super(fingerings ?? Map<int, ChordScaleFingeringsModel>.from({}));

  createChordScaleFingerings(
      List<ChordModel> selectedChords, Settings settings) {
    for (var item in selectedChords) {
      var fingering = FingeringsColorBloc().createChordsScales(item, settings);
      print(fingering);
    }
  }

  deleteFingering(int index) {
    state.removeWhere((key, value) => key == index);
  }

  clearFingerings() {
    state.clear();
  }
}
