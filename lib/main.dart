import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

//TODO: Fix PERFORMANCE ISSUES
//TODO: fix dropdown overflow
//TODO: Fix bassNoteIndex calculation
//TODO: Change player chords notes indexes (currently '2') to '3' or '4'
//TODO: Fix notes on keyboard
//TODO: Fix stop button

void main() async {
  try {
    WidgetsBinding widgetsBiding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBiding);
    // await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
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
