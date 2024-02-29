import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_sequencer/track.dart';
import 'package:flutter_sequencer/global_state.dart';
import 'package:flutter/scheduler.dart';
import 'package:scale_master_guitar/UI/player_page/provider/selected_chords_provider.dart';

import '../../../constants.dart';
import '../../../constants/music_constants.dart';
import '../../../models/project_state.dart';
import '../../../models/chord_model.dart';
import '../../../models/step_sequencer_state.dart';
import '../../../utils/player_utils.dart';
import '../../fretboard/provider/beat_counter_provider.dart';
import '../provider/chord_extensions_provider.dart';
import '../provider/is_metronome_selected.dart';
import '../provider/metronome_tempo_provider.dart';
import 'package:collection/collection.dart';

import '../provider/stop_sequencer_provider.dart';
import '../provider/tonic_universal_note_provider.dart';
import 'chord_player_bar.dart';

Function eq = const ListEquality().equals;
bool _listEquals(List list1, List list2) {
  return eq(list1, list2);
}

class PlayerWidget extends ConsumerStatefulWidget {
  const PlayerWidget({
    super.key,
  });

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
  double tempo = Constants.INITIAL_TEMPO;
  double position = 0.0;
  bool isPlaying = false;
  bool isLooping = Constants.INITIAL_IS_LOOPING;
  late Sequence sequence;
  int stepCount = 0;
  List<ChordModel> _lastChords = [];
  List<String> _lastExtensions = [];

  bool isLoading = false; // Add a boolean flag to track loading state

  initializeSequencer(
      List<ChordModel> selectedChords, List<String> extensions) {
    if (isPlaying) {
      handleStop();
    }

    setState(() {
      isLoading = true; // Set loading flag to true when initialization starts
    });

    stepCount = ref.read(beatCounterProvider);
    sequence = Sequence(tempo: tempo, endBeat: stepCount.toDouble());

    GlobalState().setKeepEngineRunning(true);

    final instruments = SoundPlayerUtils.instruments;

    sequence.createTracks(instruments).then((tracks) {
      this.tracks = tracks;
      for (var track in tracks) {
        trackVolumes[track.id] = 0.0;
        trackStepSequencerStates[track.id] = StepSequencerState();
      }

      ProjectState project = createProject(selectedChords);
      loadProjectState(project);

      setState(() {
        selectedTrack = tracks[0];
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    var selectedChords = ref.read(selectedChordsProvider);
    var extensions = ref.read(chordExtensionsProvider);
    initializeSequencer(selectedChords, extensions);

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
        // isLoading = false;
      });
    });
    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  ProjectState createProject(List<ChordModel>? selectedChords) {
    ProjectState project = ProjectState.empty(stepCount);

    bool isScaleTonicSelected =
        ref.read(tonicUniversalNoteProvider); //TODO: check this

    selectedChords?.forEach((chord) {
      for (var note in chord.selectedChordPitches!) {
        project.pianoState.setVelocity(
            chord.position, MusicConstants.midiValues[note]!, 0.60);
      }

      var note = isScaleTonicSelected
          ? "${chord.parentScaleKey}2"
          : chord.chordNotesWithIndexesRaw.first;
      var bassMidiValue = MusicConstants.midiValues[note]!;
      project.bassState.setVelocity(chord.position, bassMidiValue, 0.99);
    });

    if (ref.read(isMetronomeSelectedProvider)) {
      int nBeats = ref.read(beatCounterProvider);
      for (int i = 0; i < nBeats; i++) {
        project.drumState
            .setVelocity(0, MusicConstants.midiValues['C2']!, 0.99);
      }
    }
    return project;
  }

  handleTogglePlayPause() {
    if (isPlaying) {
      sequence.pause();
    } else {
      if (_needToUpdateSequencer()) {
        _updateSequencer();
      }
      ref.read(isSequencerStoppedProvider.notifier).update((state) => false);
      sequence.play();
    }
  }

  handleStop() {
    sequence.stop();
  }

  handleSetLoop(bool nextIsLooping) {
    if (nextIsLooping) {
      sequence.setLoop(0, stepCount.toDouble());
    } else {
      sequence.unsetLoop();
    }

    setState(() {
      isLooping = nextIsLooping;
    });
  }

  handleToggleLoop() {
    final nextIsLooping = !isLooping;

    handleSetLoop(nextIsLooping);
  }

  handleStepCountChange(int nextStepCount) {
    if (nextStepCount < 1) return;

    sequence.setEndBeat(nextStepCount.toDouble());

    if (isLooping) {
      final nextLoopEndBeat = nextStepCount.toDouble();

      sequence.setLoop(0.toDouble(), nextLoopEndBeat);
    }

    setState(() {
      stepCount = nextStepCount;
      for (var track in tracks) {
        syncTrack(track);
      }
    });
  }

  handleTempoChange(nextTempo) {
    if (nextTempo <= 0) return;
    sequence.setTempo(nextTempo);
    ref.read(metronomeTempoProvider.notifier).changeTempo(nextTempo);
  }

  handleTrackChange(Track nextTrack) {
    setState(() {
      selectedTrack = nextTrack;
    });
  }

  handleVolumeChange(double nextVolume) {
    selectedTrack!.changeVolumeNow(volume: nextVolume);
  }

  handleVelocitiesChange(
      int trackId, int step, int noteNumber, double velocity) {
    final track = tracks.firstWhere((track) => track.id == trackId);

    trackStepSequencerStates[trackId]!.setVelocity(step, noteNumber, velocity);

    syncTrack(track);
  }

  syncTrack(track) {
    track.clearEvents();
    trackStepSequencerStates[track.id]!
        .iterateEvents((step, noteNumber, velocity) {
      if (step < stepCount) {
        track.addNote(
            noteNumber: noteNumber,
            velocity: velocity,
            startBeat: step.toDouble(),
            durationBeats: 1.0);
      }
    });
    track.syncBuffer();
  }

  loadProjectState(ProjectState projectState) {
    handleStop();

    trackStepSequencerStates[tracks[0].id] = projectState.drumState;
    trackStepSequencerStates[tracks[1].id] = projectState.pianoState;
    trackStepSequencerStates[tracks[2].id] = projectState.bassState;

    var tempo = ref.read(metronomeTempoProvider) as double;
    handleStepCountChange(projectState.stepCount);
    handleTempoChange(tempo);
    handleSetLoop(projectState.isLooping);

    syncTrack(tracks[0]);
    syncTrack(tracks[1]);
    syncTrack(tracks[2]);
  }

  clearTracks() {
    sequence.stop();
    trackStepSequencerStates[tracks[0].id] = StepSequencerState();
    syncTrack(tracks[0]);
    ref.read(selectedChordsProvider.notifier).removeAll();
    setState(() {});
  }

  // Future<bool> popped() {
  //   handleStop();
  //   return Future.value(true);
  // }

  @override
  Widget build(BuildContext context) {
    var isStopped = ref.watch(isSequencerStoppedProvider);
    if (!isStopped) {
      handleStop();
    }
    // final extensions = ref.watch(chordExtensionsProvider);
    // final selectedChords = ref.watch(selectedChordsProvider);
    // ref.watch(tonicUniversalNoteProvider);

    // if (_needToUpdateSequencer(selectedChords, extensions)) {
    //   handleStop();
    //   _updateSequencer(selectedChords, extensions);
    // }

    return ChordPlayerBar(
      selectedTrack: selectedTrack,
      isLoading: isLoading,
      isPlaying: isPlaying,
      tempo: tempo,
      isLooping: isLooping,
      onTogglePlayPause: handleTogglePlayPause,
      onStop: handleStop,
      onToggleLoop: handleToggleLoop,
      clearTracks: clearTracks,
      handleTogglePlayPause: handleTogglePlayPause,
      handleStop: handleStop,
      handleToggleLoop: handleToggleLoop,
      handleTempoChange: () => handleTempoChange(tempo),
    );
  }

  bool _needToUpdateSequencer() {
    final newChords = ref.read(selectedChordsProvider);
    final extensions = ref.read(chordExtensionsProvider);
    return !_listEquals(newChords, _lastChords) ||
        !_listEquals(extensions, _lastExtensions);
  }

  Function eq = const ListEquality().equals;
  bool _listEquals(List list1, List list2) {
    return eq(list1, list2);
  }

  void _updateSequencer() {
    final newChords = ref.read(selectedChordsProvider);
    final extensions = ref.read(chordExtensionsProvider);
    initializeSequencer(newChords, extensions);
    _lastChords = newChords;
    _lastExtensions = extensions;
  }
}
