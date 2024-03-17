import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_sequencer/track.dart';
import 'package:scale_master_guitar/UI/player_page/provider/selected_chords_provider.dart';
import 'package:scale_master_guitar/constants.dart';

import '../../models/scale_model.dart';
import '../../models/settings_model.dart';
import '../../models/step_sequencer_state.dart';
import '../../utils/player_utils.dart';
import '../fretboard/provider/beat_counter_provider.dart';
import '../player_page/logic/sequencer_manager.dart';
import '../player_page/provider/chord_extensions_provider.dart';
import '../player_page/provider/is_metronome_selected.dart';
import '../player_page/provider/is_playing_provider.dart';
import '../player_page/provider/metronome_tempo_provider.dart';
import '../player_page/provider/tonic_universal_note_provider.dart';
import 'custom_piano.dart';

class CustomPianoSoundController extends ConsumerStatefulWidget {
  const CustomPianoSoundController(this.scaleInfo, {Key? key})
      : super(key: key);

  final ScaleModel? scaleInfo;

  @override
  CustomPianoState createState() => CustomPianoState();
}

class CustomPianoState extends ConsumerState<CustomPianoSoundController>
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
  late Sequence sequence;
  Map<String, dynamic> sequencer = {};
  late bool isLoading;
  late Settings settings;

  @override
  void initState() {
    super.initState();
    initializeSequencer();
  }

  Future<void> initializeSequencer() async {
    setState(() {
      isLoading = true;
    });

    isPlaying = ref.read(isSequencerPlayingProvider);
    sequencerManager = ref.read(sequencerManagerProvider);

    await getSequencer();

    // Start ticker
    ticker = createTicker((Duration elapsed) {
      setState(() {
        tempo = sequence.getTempo();
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
        playAllInstruments: false,
        instruments: SoundPlayerUtils.getInstruments(
            widget.scaleInfo!.settings!,
            onlyKeys: true),
        isPlaying: ref.read(isSequencerPlayingProvider),
        stepCount: ref.read(beatCounterProvider),
        trackVolumes: trackVolumes,
        trackStepSequencerStates: trackStepSequencerStates,
        selectedChords: ref.read(selectedChordsProvider),
        selectedTrack: selectedTrack,
        isLoading: isLoading,
        isMetronomeSelected: ref.read(isMetronomeSelectedProvider),
        isScaleTonicSelected: ref.read(tonicUniversalNoteProvider),
        tempo: ref.read(metronomeTempoProvider) as double,
        extensions: ref.read(chordExtensionsProvider));

    sequence = sequencer['sequence'];
    tracks = sequencer['tracks'];
  }

  @override
  Widget build(BuildContext context) {
    return CustomPiano(
      widget.scaleInfo,
      onKeyPressed: sequencerManager.playPianoNote,
    );
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }
}
