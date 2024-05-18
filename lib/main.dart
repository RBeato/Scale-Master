import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_preview/device_preview.dart';
import 'UI/fretboard/provider/fingerings_provider.dart';
import 'home_page.dart';

//TODO: Fix PERFORMANCE ISSUES
//TODO: fix dropdown overflow
//TODO: fix voice leading
//TODO: manage excessive clicking on the player page
//TODO: new fretboard page

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    final container = ProviderContainer();
    await container.read(chordModelFretboardFingeringProvider.future);
    FlutterNativeSplash.remove();

    runApp(DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const ProviderScope(child: MyApp())));
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
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Scale Master Guitar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomePage(title: 'Scale Master Guitar'),
    );
  }
}
