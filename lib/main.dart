import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

//TODO: Add intervals instead of notes to the fretboard
//TODO: Show chord notes on the fretboard

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
      title: 'Scale Master Guitar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomePage(title: 'Scale Master Guitar'),
    );
  }
}
