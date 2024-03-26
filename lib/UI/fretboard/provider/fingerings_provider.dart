import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/flats_and_sharps_to_flats_converter.dart';
import '../../../constants/scales/scales_data_v2.dart';
import '../../../models/scale_model.dart';
import '../../../models/chord_scale_model.dart';
import '../../../utils/music_utils.dart';
import '../../drawer/provider/settings_state_notifier.dart';
import '../../chromatic_wheel/provider/top_note_provider.dart';
import '../../scale_selection_dropdowns/provider/mode_dropdown_value_provider.dart';
import '../../scale_selection_dropdowns/provider/scale_dropdown_value_provider.dart';
import '../service/fingerings_positions_and_color.dart';

final chordModelFretboardFingeringProvider =
    FutureProvider.autoDispose<ChordScaleFingeringsModel?>((ref) async {
  final topNote = ref.watch(topNoteProvider);
  final scale = ref.watch(scaleDropdownValueProvider);
  final mode = ref.watch(modeDropdownValueProvider);

  // final settings = await ref.watch(settingsProvider.future);
  final settings =
      await ref.watch(settingsStateNotifierProvider.notifier).settings;

  final List<String> scaleNotesNames = MusicUtils.createChords(
      settings, flatsAndSharpsToFlats(topNote), scale, mode);

  ScaleModel item = ScaleModel(
    parentScaleKey: topNote,
    scale: scale.toString(),
    scaleNotesNames: scaleNotesNames,
    chordTypes: Scales.data[scale.toString()][mode]['chordType'],
    degreeFunction: Scales.data[scale.toString()][mode]['function'],
    mode: mode,
    settings: settings,
    originModeType: '',
  );

  ChordScaleFingeringsModel fingering =
      FingeringsCreator().createChordsScales(item, settings);

  return fingering;
});

class ChordModelFretboardFingeringsProvider
    extends StateNotifier<Map<int, ChordScaleFingeringsModel>> {
  ChordModelFretboardFingeringsProvider({
    fingerings,
  }) : super(fingerings ?? Map<int, ChordScaleFingeringsModel>.from({}));

  deleteFingering(int index) {
    state.removeWhere((key, value) => key == index);
  }

  clearFingerings() {
    state.clear();
  }
}
