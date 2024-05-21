import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/chromatic_wheel/chromatic_wheel.dart';
import 'package:scale_master_guitar/UI/drawer/UI/drawer/custom_drawer.dart';

import '../chromatic_wheel/provider/top_note_provider.dart';
import '../custom_piano/custom_piano_player.dart';
import '../fretboard/provider/fingerings_provider.dart';
import '../player_page/player_page.dart';
import '../scale_selection_dropdowns/scale_selection.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(topNoteProvider);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlayerPage()));
            },
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 1, child: ScaleSelector()),
            const Expanded(
              flex: 8,
              child: WheelAndPianoColumn(),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}

class WheelAndPianoColumn extends ConsumerWidget {
  const WheelAndPianoColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);
    return fingerings.when(
      data: (data) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Center(child: ChromaticWheel(data!.scaleModel!)),
              ),
              const SizedBox(height: 30),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomPianoSoundController(data.scaleModel),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: Colors.orange),
      ),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:scale_master_guitar/UI/chromatic_wheel/chromatic_wheel.dart';
// import 'package:scale_master_guitar/UI/drawer/UI/drawer/custom_drawer.dart';

// import '../chromatic_wheel/provider/top_note_provider.dart';
// import '../custom_piano/custom_piano_player.dart';
// import '../fretboard/provider/fingerings_provider.dart';
// import '../player_page/player_page.dart';
// import '../scale_selection_dropdowns/scale_selection.dart';

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key, required this.title});

//   final String title;

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends ConsumerState<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     ref.watch(topNoteProvider);

//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       appBar: AppBar(
//         backgroundColor: Colors.grey[800],
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => PlayerPage()));
//             },
//             icon: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(flex: 1, child: ScaleSelector()),
//             const Expanded(
//               flex: 8,
//               child: WheelAndPianoColumn(),
//             ),
//             const SizedBox(
//               height: 20,
//             )
//           ],
//         ),
//       ),
//       drawer: CustomDrawer(),
//     );
//   }
// }

// class WheelAndPianoColumn extends StatelessWidget {
//   const WheelAndPianoColumn({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: const [
//           Expanded(
//             flex: 2,
//             child: Center(child: ChromaticWheelWidget()),
//           ),
//           Expanded(
//             flex: 1,
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: CustomPianoSoundControllerWidget(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChromaticWheelWidget extends ConsumerWidget {
//   const ChromaticWheelWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final fingerings = ref.watch(fingeringsProvider);
//     return fingerings.when(
//       data: (data) {
//         return ChromaticWheel(data!.scaleModel!);
//       },
//       loading: () => const Center(
//         child: CircularProgressIndicator(color: Colors.orange),
//       ),
//       error: (error, stackTrace) => Text('Error: $error'),
//     );
//   }
// }

// class CustomPianoSoundControllerWidget extends ConsumerWidget {
//   const CustomPianoSoundControllerWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final fingerings = ref.watch(fingeringsProvider);
//     return fingerings.when(
//       data: (data) {
//         return CustomPianoSoundController(data!.scaleModel);
//       },
//       loading: () => const Center(
//         child: CircularProgressIndicator(color: Colors.orange),
//       ),
//       error: (error, stackTrace) => Text('Error: $error'),
//     );
//   }
// }

