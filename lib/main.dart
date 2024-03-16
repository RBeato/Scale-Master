import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

//TODO: Add intervals instead of notes to the fretboard
//TODO: Add voice leading to chord progressions
//TODO: Set maximum number of chords to be played
//TODO: Fix harmony for 5,6,8 notes scales. Perhaps review all harmony logic
//TODO: add colors to home screen and make degrees appear and disappear according to the scale
//TODO: Fix 'Scale Tonic as Universal Bass Note' feature. It's not working properly
//TODO: Fix PERFORMANCE ISSUES
//TODO: Fix settings
//TODO: Add adapted chromatic scale list to every scale to avoid problems with b5 and #11 for example

void main() {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const ProviderScope(child: MyApp())); //?
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
