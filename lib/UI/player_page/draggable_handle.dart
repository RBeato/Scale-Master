import 'package:flutter/material.dart';

import 'extensions_selection.dart';
import 'scale_tonic_universal_note.dart';

class DraggableHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show bottom sheet when tapped
        showBottomSheet(context);
      },
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: const Center(
          child: Icon(Icons.keyboard_arrow_up),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true, // Set to true to allow minimum height
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.black87,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10),
                SizedBox(
                  height: 200, // Set a fixed height for the widget
                  child: ExtensionsSelectionWidget(),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 200, // Set a fixed height for the widget
                  child: ScaleTonicAsUniversalNote(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
