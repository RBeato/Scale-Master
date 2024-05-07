// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'widget_to_png_exporter.dart';

// class SaveImageButton extends StatelessWidget {
//   const SaveImageButton({Key? key}) : super(key: key);

//   Future<void> _requestStoragePermission(BuildContext context) async {
//     // Request permission
//     PermissionStatus status = await Permission.storage.request();

//     // Check if permission is granted
//     if (status.isGranted) {
//       // Permission is granted, proceed with saving the image
//       _saveImage(context);
//     } else {
//       // Permission is denied, handle accordingly
//       print('Storage permission denied.');
//     }
//   }

//   Future<void> _saveImage(BuildContext context) async {
//     // Capture and save the PNG image
//     Uint8List? pngBytes =
//         await WidgetToPngExporter.globalKey.currentState?.capturePng();
//     if (pngBytes != null) {
//       String filePath =
//           'c:/Users/rbsou/Desktop/SMG_image.png'; // File path to save the image
//       await File(filePath).writeAsBytes(pngBytes);
//       print('PNG image saved: $filePath');
//     } else {
//       print('Error capturing PNG image.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () => _requestStoragePermission(context),
//       icon: const Icon(
//         Icons.image,
//         color: Colors.orangeAccent,
//       ),
//       tooltip: 'Export Widget as PNG',
//     );
//   }
// }
