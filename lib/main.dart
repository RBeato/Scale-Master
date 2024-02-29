import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

//TODO: Add intervals instead of notes to the fretboard
//TODO: Show chord notes on the fretboard
//TODO: Add voice leading to chord progressions
//TODO: Set maximum number of chords to be played
//TODO: trash button to chords bar
//TODO: all buttons to chords bar
//TODO: Fix harmony for 5,6,8 notes scales. Perhaps review all harmony logic
//TODO: add colors to home screen and make degrees appear and disappear according to the scale

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
