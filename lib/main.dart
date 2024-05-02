import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

//TODO: Fix 'Scale Tonic as Universal Bass Note' feature. It's not working properly
//TODO: Fix PERFORMANCE ISSUES
//TODO: Add metronome sound (add sound to every beat in the grid)
//TODO: Add delay to image when playing to sync metronome indicator and sound
//TODO: fix dropdown overflow

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
