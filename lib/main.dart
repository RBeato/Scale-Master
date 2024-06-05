import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'UI/fretboard/provider/fingerings_provider.dart';

import 'UI/home_page/selection_page.dart';

//TODO: https://www.youtube.com/watch?v=nYCE6I6DvSk @ 7:00

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    final container = ProviderContainer();
    // await dotenv.load(fileName: ".env");

    // if (Platform.isIOS || Platform.isMacOS) {
    //   StoreConfig(
    //     store: Store.appStore,
    //     apiKey: dotenv.env['APPLE_API_KEY']!,
    //   );
    // } else if (Platform.isAndroid) {
    //   // Run the app passing --dart-define=AMAZON=true
    //   const useAmazon = bool.fromEnvironment("amazon");
    //   StoreConfig(
    //     store: useAmazon ? Store.amazon : Store.playStore,
    //     apiKey: useAmazon
    //         ? dotenv.env['AMAZON_API_KEY']!
    //         : dotenv.env['GOOGLE_API_KEY']!,
    //   );
    // }
    // // Initialize RevenueCat
    // await Purchases.setDebugLogsEnabled(true);
    // // await Purchases.setup(dotenv.env['VAR_NAME']!);

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
      home: const SelectionPage(),
      // HomePage(title: 'Scale Master Guitar'),
    );
  }
}
