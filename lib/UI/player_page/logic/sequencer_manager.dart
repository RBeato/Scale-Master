import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sequencer/global_state.dart';
import 'package:flutter_sequencer/models/instrument.dart';
import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_sequencer/track.dart';
import 'package:scale_master_guitar/constants/general_audio_constants.dart';
import 'package:scale_master_guitar/models/project_state.dart';

import '../../../constants/music_constants.dart';
import '../../../models/chord_model.dart';
import '../../../models/step_sequencer_state.dart';
import '../../../utils/music_utils.dart';
import '../provider/is_playing_provider.dart';
import '../provider/selected_chords_provider.dart';
import 'package:collection/collection.dart';

final sequencerManagerProvider = Provider((ref) => SequencerManager());

class SequencerManager {
  Map<int, StepSequencerState> trackStepSequencerStates = {};
  List<Track> tracks = [];
  List _lastChords = [];
  List _lastExtensions = [];
  bool _lastTonicAsUniversalBassNote = true;
  bool tonicAsUniversalBassNote = true;
  bool _lastMetronomeSelected = false;
  bool isMetronomeSelected = false;
  Map<int, double> trackVolumes = {};
  Track? selectedTrack;
  double _lastTempo = Constants.INITIAL_TEMPO;
  double tempo = Constants.INITIAL_TEMPO;
  double position = 0.0;
  bool isPlaying = false;
  bool isTrackLooping = true;
  late Sequence sequence;
  int stepCount = 0;
  bool isLoading = false;
  bool playAllInstruments = true;

  Future<Map<String, dynamic>> initialize({
    playAllInstruments,
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
    required List<Instrument> instruments,
  }) async {
    if (isPlaying) {
      handleStop();
    }

    this.playAllInstruments = playAllInstruments;
    this.tempo = tempo;
    tonicAsUniversalBassNote = isScaleTonicSelected;
    print(this.tempo);
    this.isMetronomeSelected = isMetronomeSelected;
    print("isMetronome Selected: $isMetronomeSelected");

    sequence = Sequence(tempo: tempo, endBeat: stepCount.toDouble());

    GlobalState().setKeepEngineRunning(true);

    // if (!playAllInstruments) {
    //   instruments = [instruments[1]];
    // }

    return sequence.createTracks(instruments).then((createdTracks) async {
      tracks = createdTracks;
      for (var track in tracks) {
        trackVolumes[track.id] = 0.0;
        trackStepSequencerStates[track.id] = StepSequencerState();
      }

      ProjectState? project = await _createProject(
        selectedChords: selectedChords,
        stepCount: stepCount,
        nBeats: stepCount,
      );

      loadProjectState(project!);

      return {'tracks': tracks, 'sequence': sequence};
    });
  }

  Future<ProjectState>? _createProject({
    List<ChordModel>? selectedChords,
    stepCount,
    required int nBeats,
  }) async {
    ProjectState project = ProjectState.empty(stepCount);

    selectedChords?.forEach((chord) {
      for (var note in chord.selectedChordPitches!) {
        project.pianoState.setVelocity(
            chord.position, MusicConstants.midiValues[note]!, 0.60);
      }

      var note = tonicAsUniversalBassNote
          ? "${chord.parentScaleKey}2"
          : chord.chordNotesWithIndexesRaw.first;
      // print('bass note $note');
      note = MusicUtils.filterNoteNameWithSlash(note);
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

  playPianoNote(String note) {
    sequence.loopState = LoopState.Off;
    sequence.tempo = 200;
    note = MusicUtils.filterNoteNameWithSlash(note);
    int midiValue = MusicConstants.midiValues[note]!;
    tracks[1].events.clear();
    trackStepSequencerStates[tracks[1].id]!.clear();
    trackStepSequencerStates[tracks[1].id]!.setVelocity(0, midiValue, 0.60);
    _syncTrack(tracks[1]);
    sequence.play();
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

  _handleSetLoop(bool nextIsLooping) {
    if (nextIsLooping) {
      sequence.setLoop(0, stepCount.toDouble());
    } else {
      sequence.unsetLoop();
    }

    // setState(() {
    isTrackLooping = nextIsLooping;
    // });
  }

  handleToggleLoop(isLooping) {
    final nextIsLooping = !isLooping;

    _handleSetLoop(nextIsLooping);
  }

  _handleStepCountChange(int nextStepCount) {
    if (nextStepCount < 1) return;

    sequence.setEndBeat(nextStepCount.toDouble());

    if (isTrackLooping) {
      final nextLoopEndBeat = nextStepCount.toDouble();

      sequence.setLoop(0.toDouble(), nextLoopEndBeat);
    }

    stepCount = nextStepCount;
    for (var track in tracks) {
      _syncTrack(track);
    }

    // setState(() {
    //   stepCount = nextStepCount;
    //   for (var track in tracks) {
    //     syncTrack(track);
    //   }
    // });
  }

  _handleTempoChange(nextTempo) {
    if (nextTempo <= 0) return;
    sequence.setTempo(nextTempo);
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

    _syncTrack(track);
  }

  _syncTrack(track) {
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

    _handleStepCountChange(projectState.stepCount);
    _handleTempoChange(tempo);
    _handleSetLoop(projectState.isLooping);

    _syncTrack(tracks[0]);
    _syncTrack(tracks[1]);
    _syncTrack(tracks[2]);
  }

  clearTracks(ref) {
    sequence.stop();
    if (tracks.isNotEmpty) {
      trackStepSequencerStates[tracks[0].id] = StepSequencerState();
      _syncTrack(tracks[0]);
      ref.read(selectedChordsProvider.notifier).removeAll();
    }
  }

  bool needToUpdateSequencer(
    selectedChords,
    extensions,
    tempo,
    tonicAsUniversalBassNote,
    isMetronomeSelected,
  ) {
    if (!_listEquals(selectedChords, _lastChords) ||
        !_listEquals(extensions, _lastExtensions) ||
        tempo != _lastTempo ||
        tonicAsUniversalBassNote != _lastTonicAsUniversalBassNote ||
        isMetronomeSelected != _lastMetronomeSelected) {
      handleStop();
      _lastTonicAsUniversalBassNote = tonicAsUniversalBassNote;
      _lastMetronomeSelected = isMetronomeSelected;
      _lastChords = selectedChords;
      _lastExtensions = extensions;
      _lastTempo = tempo;
      return true;
    }
    return false;
  }

  Function eq = const ListEquality().equals;
  bool _listEquals(List list1, List list2) {
    return eq(list1, list2);
  }
}
