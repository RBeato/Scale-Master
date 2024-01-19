import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard/provider/selected_choreds_and_bass_provider.dart';

import '../../../models/chord_model.dart';
import '../../../models/chord_scale_model.dart';
import '../../../models/settings_model.dart';
import '../service/fingerings_positions_and_color.dart';

final chordModelFretboardFingeringProvider =
    StateNotifierProvider((ref) => ChordModelFretboardFingeringsProvider());

class ChordModelFretboardFingeringsProvider
    extends StateNotifier<Map<int, ChordScaleFingeringsModel>> {
  ChordModelFretboardFingeringsProvider({
    fingerings,
  }) : super(fingerings ?? Map<int, ChordScaleFingeringsModel>.from({}));

  createChordScaleFingerings(
      List<SelectedItem> selectedChords, Settings settings) {
    for (var item in selectedChords) {
      state[item.position] = FingeringsColorBloc()
          .createChordsScales(item.chordModel as ChordModel, settings);
    }
  }

  deleteFingering(int index) {
    state.removeWhere((key, value) => key == index);
  }

  clearFingerings() {
    state.clear();
  }
}
