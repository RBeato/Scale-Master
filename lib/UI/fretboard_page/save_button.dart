import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:permission_handler/permission_handler.dart';
import 'package:scale_master_guitar/UI/fretboard_page/widget_to_png.dart';

class SaveImageButton extends StatelessWidget {
  const SaveImageButton({Key? key}) : super(key: key);

  Future<void> _requestStoragePermission(BuildContext context) async {
    // Request permission
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      _saveImage(context);
    } else {
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
        try {
          // Get the directory for saving files
          Directory directory = await getApplicationDocumentsDirectory();
          String filePath = '${directory.path}/SMG_image.png';

          // Write the PNG bytes to the file
          await File(filePath).writeAsBytes(pngBytes);

          print('PNG image saved: $filePath');
        } catch (e) {
          print('Error saving PNG image: $e');
        }
      } else {
        print('Error capturing PNG image.');
      }
    } else {
      print('WidgetToPngExporterState not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _requestStoragePermission(context),
      child: const Icon(
        Icons.download,
        color: Colors.orangeAccent,
      ),
    );
  }
}
