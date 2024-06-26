import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_sequencer/track.dart';
import 'package:scale_master_guitar/UI/player_page/provider/selected_chords_provider.dart';
import 'package:scale_master_guitar/constants.dart';

import '../../models/scale_model.dart';
import '../../models/step_sequencer_state.dart';
import '../../utils/player_utils.dart';
import '../fretboard/provider/beat_counter_provider.dart';
import '../player_page/logic/sequencer_manager.dart';
import '../player_page/provider/is_metronome_selected.dart';
import '../player_page/provider/is_playing_provider.dart';
import '../player_page/provider/metronome_tempo_provider.dart';
import '../utils/debouncing.dart';
import 'custom_piano.dart';

class CustomPianoSoundController extends ConsumerStatefulWidget {
  const CustomPianoSoundController(this.scaleModel, {Key? key})
      : super(key: key);

  final ScaleModel? scaleModel;

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
    var stepCount = ref.read(beatCounterProvider).toDouble();

    sequence = Sequence(tempo: tempo, endBeat: stepCount);

    tracks = await sequencerManager.initialize(
        ref: ref,
        tracks: tracks,
        sequence: sequence,
        playAllInstruments: false,
        instruments: SoundPlayerUtils.getInstruments(
            widget.scaleModel!.settings!,
            onlyKeys: true),
        isPlaying: ref.read(isSequencerPlayingProvider),
        stepCount: ref.read(beatCounterProvider),
        trackVolumes: trackVolumes,
        trackStepSequencerStates: trackStepSequencerStates,
        selectedChords: ref.read(selectedChordsProvider),
        selectedTrack: selectedTrack,
        isLoading: isLoading,
        isMetronomeSelected: ref.read(isMetronomeSelectedProvider),
        isScaleTonicSelected:
            widget.scaleModel!.settings!.isTonicUniversalBassNote,
        tempo: ref.read(metronomeTempoProvider));

    // Start ticker
    ticker = createTicker((Duration elapsed) {
      setState(() {
        tempo = 120;
        //sequence.getTempo();
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

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("tracks: ${tracks[0]}");
    // return CustomPianoTest(
    //   widget.scaleModel,
    //   onKeyPressed: (note) =>
    //       sequencerManager.playPianoNote(note, tracks, sequence),
    // );
    return CustomPiano(
      widget.scaleModel,
      onKeyPressed: (note) => Debouncer.handleButtonPress(() {
        sequencerManager.playPianoNote(note, tracks, sequence);
      }),
    );
  }
}
