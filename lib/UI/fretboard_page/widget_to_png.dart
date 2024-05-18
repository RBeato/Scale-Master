import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'fretboard_options.dart';

class WidgetToPngExporter extends ConsumerStatefulWidget {
  final Widget child;

  const WidgetToPngExporter({Key? key, required this.child}) : super(key: key);

  @override
  _WidgetToPngExporterState createState() => _WidgetToPngExporterState();

  static _WidgetToPngExporterState? of(BuildContext context) {
    final _WidgetToPngExporterState? state =
        context.findAncestorStateOfType<_WidgetToPngExporterState>();
    return state;
  }
}

class _WidgetToPngExporterState extends ConsumerState<WidgetToPngExporter> {
  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List?> capturePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

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
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: FretboardOptionButtons(ref: ref),
          ),
          Expanded(flex: 9, child: Container(child: widget.child)),
        ],
      ),
    );
  }
}
