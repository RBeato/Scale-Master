import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/fretboard_page/save_button.dart';

import 'color_palette.dart';
import 'fretboard_color_change_button.dart';
import 'note_names_button.dart';
import 'provider/palette_color_provider.dart';
import 'sharp_flats_selection_button.dart';

class FretboardOptionButtons extends StatelessWidget {
  const FretboardOptionButtons({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SaveImageButton(),
            const NoteNamesButton(),
            const FretboardColorChangeButton(),
            const FretboardSharpFlatToggleButton(),
            ColorPalette(
              colors: const [
                Colors.blueGrey,
                Colors.red,
                Colors.green,
                Colors.yellow,
                Colors.purple,
              ],
              onColorSelected: (Color color) {
                ref
                    .read(paletteColorProvider.notifier)
                    .update((state) => color);
              },
            ),
          ],
        ),
      ),
    );
  }
}
