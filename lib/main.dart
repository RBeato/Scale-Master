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

//  print(Pitch.parse('C4'));
//   print(Pitch.parse('C♯4'));
//   print(Pitch.parse('C♭4'));

//   print(Pitch.parse('C#4') == Pitch.parse('C#4')); // => true
//   print(Pitch.parse('E♯4').midiNumber == Pitch.parse('F4').midiNumber); // => true
//   print(Pitch.parse('C4').octave); // => 5
//   print(Pitch.parse('C4').midiNumber); // => 60
//   print(new Pitch.fromMidiNumber(60)); // => C4
//   print(new Pitch.fromMidiNumber(60).helmholtzName); // => c'

//   // Intervals
//   print(Interval.M3);
//   print(Interval.parse('M3'));
//   print(Interval.m3.semitones); // => 3
//   print(Interval.M3.number); // => 3
//   print(Interval.M3.qualityName); // => "M"

//   print(Interval.M3 + Interval.m3); // => P5

//   print(Pitch.parse('C4') + Interval.M3); // => E

//   print(Pitch.parse('D4') - Pitch.parse('C4'));   // => M2

//   // Chords
//   print(Chord.parse('E Major'));
//   print(ChordPattern.parse('Dominant 7th')); // => Dom 7th
//   print(ChordPattern.fromIntervals([Interval.P1, Interval.M3, Interval.P5])); // => Major
//   print(ChordPattern.fromIntervals([Interval.P1, Interval.m3, Interval.P5])); // => Minor
//   print(ChordPattern.fromIntervals([Interval.P1, Interval.m3, Interval.P5, Interval.m7])); // => Min 7th

//   // Scales
//   final scalePattern = ScalePattern.findByName('Diatonic Major');
//   print(scalePattern.intervals); // => [P1, M2, M3, P4, P5, M6, M7]
//   print(scalePattern.modes);
//   print(scalePattern.modes['Dorian'].intervals); // => [P1, M2, m3, P4, P5, M6, m7]

//   final scale = scalePattern.at(Pitch.parse('E4'));
//   print(scale.intervals); // => [P1, M2, M3, P4, P5, M6, M7]
//   print(scale.pitchClasses); // => [E4, F♯4, G♯4, A4, B4, C♯5, D♯5]

//   // Instruments and fret fingerings
//   final chord = Chord.parse('E Major');
//   final instrument = Instrument.Guitar;
//   print(bestFrettingFor(chord, instrument)); // => 022100

//TODO: Create a specific voicing for specific extensions on first chord and see if voice leading works as is
//TODO: Fix 'Scale Tonic as Universal Bass Note' feature. It's not working properly
//TODO: Fix PERFORMANCE ISSUES
//TODO: Add metronome sound (add sound to every beat in the grid)
//TODO: Add delay to image when playing to sync metronome indicator and sound
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
