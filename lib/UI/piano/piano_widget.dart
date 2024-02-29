import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../custom_piano/custom_piano.dart';
import '../fretboard/provider/fingerings_provider.dart';

class PianoWidget extends ConsumerWidget {
  const PianoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);
    return Center(
      child: fingerings.when(
          data: (chordScaleFingeringsModel) {
            return CustomPiano(chordScaleFingeringsModel!.scaleModel);
          },
          loading: () => const CircularProgressIndicator(color: Colors.orange),
          error: (error, stackTrace) => Text('Error: $error')),
    );
  }
}

// class Piano extends StatelessWidget {
//   const Piano(
//     this.info, {
//     super.key,
//   });

//   final ScaleModel? info;

//   _getColor() {
//     print(info);
//     //notes to flats
//     final degrees = Scales.data[info!.scale][info!.mode]['chordType'];
//     final noteList = [];
//     final key = Pitch.parse(info!.parentScaleKey).midiNumber;
//     final intervals = Scales.data[info!.scale][info!.mode]['intervals'];
//     for (var i = 0; i < degrees.length; i++) {
//       noteList.add(key + intervals[i]);
//     }

//     // note to midi value. Note substring and search value where key contains part of the string.

//     // scale degree for color map
//     return Colors.white;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: SizedBox(
//         height: 140,
//         child: VirtualPiano(
//           whiteKeyColor: _getColor(),
//           noteRange: const RangeValues(61, 90),
//           // noteRange: const RangeValues(60, 90),
//           highlightedNoteSets: const [],
//           onNotePressed: (note, pos) {
//             print("note pressed $note pressed at $pos");
//           },
//           onNoteReleased: (note) {
//             print("note released $note");
//           },
//           onNotePressSlide: (note, pos) {
//             print("note slide $note pressed at $pos");
//           },
//           elevation: 0,
//           showKeyLabels: true,
//         ),
//       ),
//     );
//   }
// }
