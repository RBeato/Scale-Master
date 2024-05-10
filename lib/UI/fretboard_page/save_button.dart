import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:permission_handler/permission_handler.dart';
import 'package:scale_master_guitar/UI/fretboard_page/widget_to_png.dart';

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
        Icons.download,
        color: Colors.orangeAccent,
      ),
      tooltip: 'Export Widget as PNG',
    );
  }
}
