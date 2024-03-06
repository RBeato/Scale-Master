import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sequencer/global_state.dart';
import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_sequencer/track.dart';
import 'package:scale_master_guitar/constants/general_audio_constants.dart';
import 'package:scale_master_guitar/models/project_state.dart';

import '../../../constants/music_constants.dart';
import '../../../models/chord_model.dart';
import '../../../models/step_sequencer_state.dart';
import '../../../utils/player_utils.dart';
import '../provider/is_playing_provider.dart';
import '../provider/selected_chords_provider.dart';
import 'package:collection/collection.dart';

final sequencerManagerProvider = Provider((ref) => SequencerManager());

class SequencerManager {
  Map<int, StepSequencerState> trackStepSequencerStates = {};
  List<Track> tracks = [];
  List _lastChords = [];
  List _lastExtensions = [];
  Map<int, double> trackVolumes = {};
  Track? selectedTrack;
  double tempo = Constants.INITIAL_TEMPO;
  double position = 0.0;
  bool isPlaying = false;
  bool isLooping = Constants.INITIAL_IS_LOOPING;
  late Sequence sequence;
  int stepCount = 0;
  bool isLoading = false;

  Future<Map<String, dynamic>> initialize({
    isPlaying,
    stepCount,
    trackVolumes,
    selectedChords,
    trackStepSequencerStates,
    selectedTrack,
    isLoading,
    isScaleTonicSelected,
    isMetronomeSelected,
    beatCounter,
    tempo,
    extensions,
  }) async {
    if (isPlaying) {
      handleStop();
    }

    sequence = Sequence(tempo: tempo, endBeat: stepCount.toDouble());

    GlobalState().setKeepEngineRunning(true);

    final instruments = SoundPlayerUtils.instruments;

    return sequence.createTracks(instruments).then((createdTracks) async {
      tracks = createdTracks;
      for (var track in tracks) {
        trackVolumes[track.id] = 0.0;
        trackStepSequencerStates[track.id] = StepSequencerState();
      }

      ProjectState? project = await createProject(
        selectedChords: selectedChords,
        stepCount: stepCount,
        isScaleTonicSelected: isScaleTonicSelected,
        isMetronomeSelected: isMetronomeSelected,
        nBeats: stepCount,
      );

      loadProjectState(project!);

      return {'tracks': tracks, 'sequence': sequence};
    });
  }

  Future<ProjectState>? createProject({
    List<ChordModel>? selectedChords,
    stepCount,
    required bool isScaleTonicSelected,
    required bool isMetronomeSelected,
    required int nBeats,
  }) async {
    ProjectState project = ProjectState.empty(stepCount);

    // bool isScaleTonicSelected =
    //     ref.read(tonicUniversalNoteProvider); //TODO: check this

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

    if (isMetronomeSelected) {
      for (int i = 0; i < nBeats; i++) {
        project.drumState
            .setVelocity(0, MusicConstants.midiValues['C2']!, 0.99);
      }
    }
    return project;
  }

  handleTogglePlayStop(WidgetRef ref) {
    ref.read(isSequencerPlayingProvider.notifier).update((state) => !state);
    bool isPlaying = ref.read(isSequencerPlayingProvider);

    if (!isPlaying) {
      sequence.stop();
      ref.read(isSequencerPlayingProvider.notifier).update((state) => false);
    } else {
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

    // setState(() {
    //   isLooping = nextIsLooping;
    // });
  }

  handleToggleLoop(isLooping) {
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

    stepCount = nextStepCount;
    for (var track in tracks) {
      syncTrack(track);
    }

    // setState(() {
    //   stepCount = nextStepCount;
    //   for (var track in tracks) {
    //     syncTrack(track);
    //   }
    // });
  }

  handleTempoChange(nextTempo) {
    if (nextTempo <= 0) return;
    sequence.setTempo(nextTempo);
    //! ref.read(metronomeTempoProvider.notifier).changeTempo(nextTempo);
  }

  handleTrackChange(Track nextTrack) {
    selectedTrack = nextTrack;
    // setState(() {
    //   selectedTrack = nextTrack;
    // });
  }

  handleVolumeChange(double nextVolume, Track selectedTrack) {
    selectedTrack.changeVolumeNow(volume: nextVolume);
  }

  handleVelocitiesChange(int trackId, int step, int noteNumber, double velocity,
      List<Track> tracks) {
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

    //TODO: double check tempo;
    handleStepCountChange(projectState.stepCount);
    handleTempoChange(tempo);
    handleSetLoop(projectState.isLooping);

    syncTrack(tracks[0]);
    syncTrack(tracks[1]);
    syncTrack(tracks[2]);
  }

  clearTracks(ref) {
    sequence.stop();
    if (tracks.isNotEmpty) {
      trackStepSequencerStates[tracks[0].id] = StepSequencerState();
      syncTrack(tracks[0]);
      ref.read(selectedChordsProvider.notifier).removeAll();
    }
  }

  bool needToUpdateSequencer(selectedChords, extensions) {
    if (!_listEquals(selectedChords, _lastChords) ||
        !_listEquals(extensions, _lastExtensions)) {
      handleStop();
      _lastChords = selectedChords;
      _lastExtensions = extensions;
      return true;
    }
    return false;
  }

  Function eq = const ListEquality().equals;
  bool _listEquals(List list1, List list2) {
    return eq(list1, list2);
  }
}
