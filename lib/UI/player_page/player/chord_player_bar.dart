import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sequencer/track.dart';
import 'package:scale_master_guitar/UI/player_page/provider/selected_chords_provider.dart';

import '../chords_list.dart';
import '../metronome/metronome_display.dart';
import '../metronome/metronome_icon.dart';

class ChordPlayerBar extends ConsumerWidget {
  const ChordPlayerBar({
    Key? key,
    required this.selectedTrack,
    required this.isPlaying,
    required this.isLoading,
    required this.tempo,
    required this.isLooping,
    required this.handleTogglePlayStop,
    required this.clearTracks,
    required this.handleTempoChange,
  }) : super(key: key);

  final bool isPlaying;
  final Track? selectedTrack;
  final bool isLoading;
  final bool isLooping;
  final double tempo;
  final Function() clearTracks;
  final Function() handleTogglePlayStop;
  final Function() handleTempoChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChords = ref.watch(selectedChordsProvider);
    if (selectedTrack == null || selectedChords.isEmpty) {
      return const Center(
          child: Text("No chord selected!",
              style: TextStyle(color: Colors.white)));
    }
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          // SEQUENCER
          Opacity(
            opacity: 0.85,
            child: ChordListWidget(selectedChords),
          ),
          //CLEAR DRUMS BUTTON and TRANSPORT
          Positioned(
              left: 0,
              bottom: 0,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: handleTogglePlayStop,
                    child: Icon(
                      isPlaying ? Icons.stop : Icons.play_arrow,
                      color: Colors.white70,
                      size: 40,
                    ),
                  ))),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: clearTracks,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_forever,
                  size: 30,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 70,
                height: 30.0,
                child: MetronomeDisplay(
                  selectedTempo: tempo,
                  handleChange: (int value) => handleTempoChange(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: MetronomeButton(),
          ),
        ],
      ),
    );
  }
}
