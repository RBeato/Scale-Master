import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/player_page/provider/stop_sequencer_provider.dart';
import '../../../models/chord_model.dart';

import '../../fretboard/provider/beat_counter_provider.dart';
import 'chord_extensions_provider.dart';

final selectedChordsProvider =
    StateNotifierProvider<SelectedChords, List<ChordModel>>(
  (ref) {
    // final selectedChords = SelectedChords(ref);

    // // Listen to changes in chordExtensionsProvider and update selectedChords accordingly
    // ref.listen<List<String>>(chordExtensionsProvider,
    //     (extensions, previousExtensions) {
    //   // Filter selected chords based on extensions
    //   selectedChords.filterChords(extensions ?? []);
    // });

    // return selectedChords;
    return SelectedChords(ref);
  },
);

class SelectedChords extends StateNotifier<List<ChordModel>> {
  SelectedChords(this.ref, [List<ChordModel>? selectedItems])
      : super(selectedItems ?? []);

  final StateNotifierProviderRef ref;

  List<ChordModel> get selectedItemsList => state;

  void addChord(ChordModel chordModel) {
    ref.read(isSequencerStoppedProvider.notifier).update((state) => true);

    state = List.of(state)..add(chordModel);

    filterChords(ref.read(chordExtensionsProvider) ?? []);

    int sum =
        state.fold(0, (previousValue, item) => previousValue + item.duration);

    ref.read(beatCounterProvider.notifier).update((state) => sum);
  }

  void updateSelectedChords(List<ChordModel> chords) {
    state = chords;
  }

  void filterChords(List<String> extensions) {
    final extensionIndexes = {
      '7': 3,
      '9': 4,
      '11': 5,
      '13': 6,
    };

    print(state.hashCode);
    state = state.map((chord) {
      List<String> updatedPitches =
          chord.allChordExtensions?.take(3).toList() ?? [];

      for (var ext in extensions) {
        final index = extensionIndexes[ext];
        if (index != null) {
          updatedPitches.add(chord.allChordExtensions![index]);
        }
      }
      return chord.copyWith(selectedChordPitches: updatedPitches);
    }).toList();
    print(state.hashCode);
  }

  void removeAll() {
    state = [];
  }
}


// final List<String> extensions = [
//     "7",
//     "9",
//     "11",
//     "13",
//   ];


