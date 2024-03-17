import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

//TODO: Fix harmony for 5,6,8 notes scales. Perhaps review all harmony logic
//TODO: Fix 'Scale Tonic as Universal Bass Note' feature. It's not working properly
//TODO: Fix PERFORMANCE ISSUES
//TODO: Fix settings selections not being saved
//TODO: Add adapted chromatic scale list to every scale to avoid problems with b5 and #11 for example
//TODO: Change 'scaleDegrees': from all scale maps
//TODO: Create a specific voicing for specific extensions on first chord and see if voice leading works as is
//TODO: Fix metronome tempo change
//TODO: Fix empty chord list when entering player page.

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
