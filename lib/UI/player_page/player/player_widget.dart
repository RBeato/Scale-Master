import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_sequencer/track.dart';
import 'package:flutter/scheduler.dart';
import 'package:scale_master_guitar/UI/player_page/logic/sequencer_manager.dart';
import 'package:scale_master_guitar/UI/player_page/provider/selected_chords_provider.dart';
import 'package:scale_master_guitar/utils/player_utils.dart';

import '../../../constants.dart';
import '../../../models/settings_model.dart';
import '../../../models/step_sequencer_state.dart';
import '../../fretboard/provider/beat_counter_provider.dart';
import '../provider/chord_extensions_provider.dart';

import '../provider/is_metronome_selected.dart';
import '../provider/metronome_tempo_provider.dart';
import '../provider/is_playing_provider.dart';
import '../provider/tonic_universal_note_provider.dart';
import 'chord_player_bar.dart';

class PlayerWidget extends ConsumerStatefulWidget {
  const PlayerWidget(
    this.settings, {
    super.key,
  });

  final Settings settings;

  @override
  PlayerPageShowcaseState createState() => PlayerPageShowcaseState();
}

class PlayerPageShowcaseState extends ConsumerState<PlayerWidget>
    with SingleTickerProviderStateMixin {
  Map<int, StepSequencerState> trackStepSequencerStates = {};
  List<Track> tracks = [];
  Map<int, double> trackVolumes = {};
  Track? selectedTrack;
  late Ticker ticker;
  SequencerManager sequencerManager = SequencerManager();
  double tempo = Constants.INITIAL_TEMPO;
  double position = 0.0;
  late bool isPlaying;
  bool isLooping = Constants.INITIAL_IS_LOOPING;
  late Sequence sequence;
  Map<String, dynamic> sequencer = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    initializeSequencer();
  }

  void initializeSequencer() async {
    setState(() {
      isLoading = true;
    });

    // Initialize sequencer manager
    isPlaying = ref.read(isSequencerPlayingProvider);
    sequencerManager = ref.read(sequencerManagerProvider);

    // Initialize sequencer and tracks
    await getSequencer();

    // Start ticker
    ticker = createTicker((Duration elapsed) {
      setState(() {
        tempo = ref.read(metronomeTempoProvider); //sequence.getTempo();
        position = sequence.getBeat();
        isPlaying = sequence.getIsPlaying();

        ref
            .read(currentBeatProvider.notifier)
            .update((state) => position.toInt());

        for (var track in tracks) {
          trackVolumes[track.id] = track.getVolume();
        }
        setState(() {
          isLoading = false;
        });
      });
    });
    ticker.start();
  }

  Future<void> getSequencer() async {
    sequencer = await sequencerManager.initialize(
        playAllInstruments: true,
        instruments: SoundPlayerUtils.getInstruments(widget.settings),
        isPlaying: ref.read(isSequencerPlayingProvider),
        stepCount: ref.read(beatCounterProvider),
        trackVolumes: trackVolumes,
        trackStepSequencerStates: trackStepSequencerStates,
        selectedChords: ref.read(selectedChordsProvider),
        selectedTrack: selectedTrack,
        isLoading: isLoading,
        isMetronomeSelected: ref.read(isMetronomeSelectedProvider),
        isScaleTonicSelected: ref.read(tonicUniversalNoteProvider),
        tempo: ref.read(metronomeTempoProvider),
        extensions: ref.read(chordExtensionsProvider));

    sequence = sequencer['sequence'];
    tracks = sequencer['tracks'];
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isPlaying = ref.watch(isSequencerPlayingProvider);
    if (!isPlaying) {
      sequencerManager.handleStop();
    }
    final extensions = ref.watch(chordExtensionsProvider);
    final tonicAsUniversalBassNote = ref.watch(tonicUniversalNoteProvider);
    final selectedChords = ref.watch(selectedChordsProvider);
    ref.watch(metronomeTempoProvider);
    final isMetronomeSelected = ref.watch(isMetronomeSelectedProvider);

    updateSequencer(
      selectedChords,
      extensions,
      tonicAsUniversalBassNote,
      isMetronomeSelected,
    );

    return ChordPlayerBar(
      selectedTrack: selectedTrack,
      isLoading: isLoading,
      isPlaying: isPlaying,
      tempo: ref.read(metronomeTempoProvider),
      isLooping: isLooping,
      clearTracks: () => sequencerManager.clearTracks(ref),
      handleTogglePlayStop: () => sequencerManager.handleTogglePlayStop(ref),
    );
  }

  updateSequencer(
    List selectedChords,
    List extensions,
    bool tonicAsUniversalBassNote,
    bool isMetronomeSelected,
  ) {
    if (sequencerManager.needToUpdateSequencer(
      selectedChords,
      extensions,
      tempo,
      tonicAsUniversalBassNote,
      isMetronomeSelected,
    )) {
      setState(() {
        isLoading = true; // Set loading flag to true when initialization starts
      });

      //add new chords to sequence.
      getSequencer();
      setState(() {
        selectedTrack = tracks[0];
        isLoading = false;
      });
    }
  }
}
