import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/player_page/provider/selected_chords_provider.dart';

import 'provider/chord_extensions_provider.dart';

class ExtensionsSelectionWidget extends StatelessWidget {
  ExtensionsSelectionWidget({super.key});

  final List<String> extensions = [
    "7",
    "9",
    "11",
    "13",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const Expanded(
            child: Text(
              "Extensions:",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // To distribute space evenly
              children: extensions
                  .map((e) => Expanded(child: ExtensionButton(e)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ExtensionButton extends ConsumerWidget {
  ExtensionButton(this.text, {super.key});

  final String text;

  bool isSelected = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Wrap your Container with IntrinsicWidth for consistent width
    isSelected = ref.watch(chordExtensionsProvider).contains(text);
    return GestureDetector(
      onTap: () {
        isSelected = !isSelected;
        if (isSelected) {
          ref.read(chordExtensionsProvider.notifier).addExtension(text);
        }
        if (!isSelected) {
          ref.read(chordExtensionsProvider.notifier).removeExtension(text);
        }
        ref
            .read(selectedChordsProvider.notifier)
            .filterChords(ref.read(chordExtensionsProvider) ?? []);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.green
                : Colors.black12, // Set the background color
            borderRadius: BorderRadius.circular(10), // Add rounded corners
            border: Border.all(
              color: Colors.white,
              width: 2,
            ), // Add a white border
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
