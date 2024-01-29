import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/mode_dropdown_value_provider.dart';
import 'provider/scale_dropdown_value_provider.dart';

class ScaleSelector extends ConsumerStatefulWidget {
  @override
  _ScaleSelectorState createState() => _ScaleSelectorState();
}

class _ScaleSelectorState extends ConsumerState<ScaleSelector> {
  String? selectedScale;
  String? selectedMode;
  String? selectedChordType;

  // Define your lists of options
  final List<String> scales = [
    'Diatonic Major',
    'Melodic Minor',
    'Harmonic Minor',
    'Harmonic Major',
    'Pentatonic',
    'Octatonic',
    'Hexatonic'
  ];
  final List<String> chordTypes = [
    'Triad',
    'Seventh',
    'Ninth',
    'Eleventh',
    'Thirteenth'
  ];

  // Logic to determine the modes based on the selected scale
  List<String> getModesForScale(String scale) {
    // Implement your logic here to return the list of modes for the given scale
    return ['Mode 1', 'Mode 2']; // Placeholder list
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  setState(() {
                    ref
                        .read(scaleDropdownValueProvider.notifier)
                        .update((state) => newValue!);
                    selectedScale = newValue!;
                    selectedMode = null; // Reset mode when scale changes
                  });
                },
                items: scales.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
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
            child: DropdownButtonFormField<String>(
              dropdownColor: Colors.grey[800],
              value: selectedMode,
              onChanged: (newValue) {
                ref
                    .read(modeDropdownValueProvider.notifier)
                    .update((state) => newValue!);
                setState(() {
                  selectedMode = newValue!;
                });
              },
              items: selectedScale != null
                  ? getModesForScale(selectedScale!)
                      .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70)),
                      );
                    }).toList()
                  : [],
              hint: const Text('Select Mode',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white70)),
            ),
          ),
          // Expanded(
          //   child: DropdownButtonFormField<String>(
          //     value: selectedChordType,
          //     onChanged: (newValue) {
          //       setState(() {
          //         selectedChordType = newValue!;
          //       });
          //     },
          //     items: chordTypes.map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //     hint: const Text(
          //       'Select Chord Type',
          //       overflow: TextOverflow.ellipsis,
          //       style: TextStyle(color: Colors.white12),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
