import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

//TODO: Fix harmony for 5,6,8 notes scales. Perhaps review all harmony logic. Perhaps create a way of reading the scale degrees and calculate the chords name based on the intervals. For pentatonis use quartal??, for octatonic pick 3rd. Reformulate the way the chord list is built

// List modeIntervals = Scales.data['scale']['mode']['scaleDegrees']
//     .where((element) => element != null)
//     .toList();

// chordLogicFromIntervals(modeIntervals);
// build the chords names from the  'scaleDegrees' list and create the names rules from there.
// for creating chords inside the mode, refer to other modes structures. Reorder modes inside the map so the search can be done by key number... and call MusicUtils.getTriadType() on it.
// replace everything where the map keys 'function' and  'chordType are used to create the chords

//TODO: Fix 'Scale Tonic as Universal Bass Note' feature. It's not working properly
//TODO: Fix PERFORMANCE ISSUES
//TODO: Add adapted chromatic scale list to every scale to avoid problems with b5 and #11 for example
//TODO: Create a specific voicing for specific extensions on first chord and see if voice leading works as is
//TODO: Add metronome sound (add sound to every beat in the grid)
//TODO: Add delay to image when playing to sync metronome indicator and sound
//TODO: Remove excess piano notes at tops
//TODO: pentatonics dropdown lags a lot

void main() {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const ProviderScope(child: MyApp()));
  } catch (error) {
    print('Setup has failed');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
      title: 'Scale Master Guitar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomePage(title: 'Scale Master Guitar'),
    );
  }
}
