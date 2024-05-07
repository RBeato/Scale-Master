import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard/UI/fretboard_painter.dart';
import '../provider/fingerings_provider.dart';
import 'dart:ui' as ui;

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';

class WidgetToPngExporter extends StatefulWidget {
  final Widget child;

  const WidgetToPngExporter({Key? key, required this.child}) : super(key: key);

  @override
  _WidgetToPngExporterState createState() => _WidgetToPngExporterState();

  // Add a static method to access the state
  static _WidgetToPngExporterState? of(BuildContext context) {
    final _WidgetToPngExporterState? state =
        context.findAncestorStateOfType<_WidgetToPngExporterState>();
    return state;
  }
}

class _WidgetToPngExporterState extends State<WidgetToPngExporter> {
  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List?> capturePng() async {
    try {
      // Render the widget to a raster layer.
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(
          pixelRatio: 3.0); // Adjust pixelRatio as needed for image quality.

      // Convert the image to PNG format.
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('Error capturing PNG: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: widget.child,
    );
  }
}

class SaveImageButton extends StatelessWidget {
  const SaveImageButton({Key? key}) : super(key: key);

  Future<void> _requestStoragePermission(BuildContext context) async {
    // Request permission
    PermissionStatus status = await Permission.storage.request();

    // Check if permission is granted
    if (status.isGranted) {
      // Permission is granted, proceed with saving the image
      _saveImage(context);
    } else {
      // Permission is denied, handle accordingly
      print('Storage permission denied.');
    }
  }

  Future<void> _saveImage(BuildContext context) async {
    // Find the WidgetToPngExporterState
    final widgetToPngExporterState = WidgetToPngExporter.of(context);
    if (widgetToPngExporterState != null) {
      // Call the capturePng method
      Uint8List? pngBytes = await widgetToPngExporterState.capturePng();
      if (pngBytes != null) {
        String filePath =
            'c:/Users/rbsou/Desktop/SMG_image.png'; // File path to save the image
        await File(filePath).writeAsBytes(pngBytes);
        print('PNG image saved: $filePath');
      } else {
        print('Error capturing PNG image.');
      }
    } else {
      print('WidgetToPngExporterState not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _requestStoragePermission(context),
      icon: const Icon(
        Icons.image,
        color: Colors.orangeAccent,
      ),
      tooltip: 'Export Widget as PNG',
    );
  }
}

class Fretboard extends ConsumerWidget {
  Fretboard({Key? key}) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int stringCount = 6;
    int fretCount = 24;
    final fingerings = ref.watch(chordModelFretboardFingeringProvider);

    return SizedBox(
      height: 200,
      child: fingerings.when(
        data: (data) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 50.0,
              ),
              child: RepaintBoundary(
                child: WidgetToPngExporter(
                  child: CustomPaint(
                    painter: FretboardPainter(
                      stringCount: stringCount,
                      fretCount: fretCount,
                      fingeringsModel: data!,
                    ),
                    child: SizedBox(
                      width: fretCount.toDouble() * 36,
                      height: stringCount.toDouble() * 24,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        loading: () => const CircularProgressIndicator(color: Colors.orange),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }
}




// class Fretboard extends ConsumerWidget {
//   Fretboard({Key? key}) : super(key: key);

//   final _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     int stringCount = 6;
//     int fretCount = 24;
//     final fingerings = ref.watch(chordModelFretboardFingeringProvider);

//     return SizedBox(
//       height: 200,
//       child: fingerings.when(
//         data: (data) {
//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             controller: _scrollController,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 20.0,
//                 horizontal: 50.0,
//               ),
//               child: RepaintBoundary(
//                 child: WidgetToPngExporter(
//                   child: CustomPaint(
//                     painter: FretboardPainter(
//                       stringCount: stringCount,
//                       fretCount: fretCount,
//                       fingeringsModel: data!,
//                     ),
//                     child: SizedBox(
//                       width: fretCount.toDouble() * 36,
//                       height: stringCount.toDouble() * 24,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//         loading: () => const CircularProgressIndicator(color: Colors.orange),
//         error: (error, stackTrace) => Text('Error: $error'),
//       ),
//     );
//   }
// }
