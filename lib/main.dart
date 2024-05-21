import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'UI/fretboard/provider/fingerings_provider.dart';
import 'UI/home_page/home_page.dart';

//TODO: Fix PERFORMANCE ISSUES
//TODO: fix voice leading. First chord doesn't voice lead to others....
//TODO: manage excessive clicking on the player page
//TODO: Fix 6th fretboard page
//TODO: Fix Excessive loading on main page
//TODO: Create Icon and app name

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    final container = ProviderContainer();
    await container.read(chordModelFretboardFingeringProvider.future);
    FlutterNativeSplash.remove();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) {
      runApp(
          // DevicePreview(
          //   enabled: !kReleaseMode,
          //   builder: (context) => const
          const ProviderScope(child: MyApp())
          // )
          );
    });
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
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      title: 'Scale Master Guitar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomePage(title: 'Scale Master Guitar'),
    );
  }
}
