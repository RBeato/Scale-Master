import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/scales/scales_data_v2.dart';
import 'provider/mode_dropdown_value_provider.dart';
import 'provider/scale_dropdown_value_provider.dart';

class ScaleSelector extends ConsumerStatefulWidget {
  @override
  _ScaleSelectorState createState() => _ScaleSelectorState();
}

class _ScaleSelectorState extends ConsumerState<ScaleSelector> {
  String? selectedMode;
  String? selectedChordType;

  @override
  Widget build(BuildContext context) {
    final selectedScale = ref.watch(scaleDropdownValueProvider);
    final selectedMode = ref.watch(modeDropdownValueProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width *
                    0.3, // Adjust the max width as needed
              ),
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.grey[800],
                value: selectedScale,
                onChanged: (newValue) {
                  ref.read(scaleDropdownValueProvider.notifier).state =
                      newValue!;
                  ref.read(modeDropdownValueProvider.notifier).state =
                      Scales.data[newValue].keys.first as String;
                  // print(ref.read(modeDropdownValueProvider.notifier).state);
                  // print(ref.read(scaleDropdownValueProvider.notifier).state);
                },
                items: Scales.data.keys
                    .map<DropdownMenuItem<String>>((dynamic value) {
                  String key = value as String;
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(key,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70)),
                  );
                }).toList(),
                hint: const Text('Select Scale',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          const SizedBox(width: 20), // Adjust the width as needed
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width *
                    0.3, // Adjust the max width as needed
              ),
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.grey[800],
                value: selectedMode,
                onChanged: (newValue) {
                  ref
                      .read(modeDropdownValueProvider.notifier)
                      .update((state) => newValue!);
                },
                items: Scales.data[selectedScale].keys
                    .map<DropdownMenuItem<String>>((dynamic value) {
                  String key = value as String;
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(key,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(color: Colors.white70)),
                  );
                }).toList(),
                hint: const Text('Select Mode',
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: Colors.white70)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
