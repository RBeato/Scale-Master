import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sequencer/models/instrument.dart';

import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_sequencer/track.dart';
import 'package:flutter_sequencer/global_state.dart';
import 'package:flutter/scheduler.dart';
import 'package:scale_master_guitar/UI/fretboard/UI/fretboard_neck.dart';

import '../../constants.dart';
import '../../hardcoded_data/music_constants.dart';
import '../../models/project_state.dart';
import '../../models/chord_model.dart';
import '../../models/step_sequencer_state.dart';
import '../../models/transport.dart';
import '../chords/chords.dart';
import '../fretboard/provider/beat_counter_provider.dart';
import 'chords_list.dart';
import 'drum_machine.dart';
import 'provider/metronome_tempo_provider.dart';

class PlayerPage extends ConsumerWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, watch, _) {
      return const PlayerPageShowcase();
    });
  }
}

class PlayerPageShowcase extends ConsumerStatefulWidget {
  const PlayerPageShowcase({
    super.key,
  });

  @override
  PlayerPageShowcaseState createState() => PlayerPageShowcaseState();
}

class PlayerPageShowcaseState extends ConsumerState<PlayerPageShowcase>
    with SingleTickerProviderStateMixin {
  Map<int, StepSequencerState> trackStepSequencerStates = {};
  List<Track> tracks = [];
  Map<int, double> trackVolumes = {};
  Track? selectedTrack;
  late Ticker ticker;
  var tempo = Constants.INITIAL_TEMPO;
  double position = 0.0;
  bool isPlaying = false;
  bool isLooping = Constants.INITIAL_IS_LOOPING;
  late Sequence sequence;
  var stepCount;

  @override
  void initState() {
    super.initState();

    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    stepCount = ref.read(beatCounterProvider) as int;
    sequence = Sequence(tempo: tempo, endBeat: stepCount.toDouble());

    GlobalState().setKeepEngineRunning(true);

    final instruments = [
      Sf2Instrument(
          path: Constants.soundPath['drums']!['Electronic'] as String,
          isAsset: true),
      Sf2Instrument(
          path: Constants.soundPath['keys']!['Rhodes'] as String,
          isAsset: true),
      Sf2Instrument(
          path: Constants.soundPath['bass']!['Double Bass'] as String,
          isAsset: true)
    ];

    sequence.createTracks(instruments).then((tracks) {
      this.tracks = tracks;
      for (var track in tracks) {
        trackVolumes[track.id] = 0.0;
        trackStepSequencerStates[track.id] = StepSequencerState();
      }

      ProjectState project = createProject(
        pianoPart: [],
        bassPart: [],
      );

      loadProjectState(project);

      setState(() {
        selectedTrack = tracks[0];
      });
    });

    ticker = createTicker((Duration elapsed) {
      setState(() {
        tempo = sequence.getTempo();
        //context.read(metronomeTempoProvider.state);
        position = sequence.getBeat();
        isPlaying = sequence.getIsPlaying();

        ref
            .read(currentBeatProvider.notifier)
            .update((state) => position.toInt());

        for (var track in tracks) {
          trackVolumes[track.id] = track.getVolume();
        }
      });
    });
    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  ProjectState createProject(
      {List<ChordModel>? pianoPart, List<ChordModel>? bassPart}) {
    ProjectState project = ProjectState.empty(stepCount);

    pianoPart?.forEach((chord) {
      for (var note in chord.organizedPitches!) {
        project.pianoState.setVelocity(
            chord.position, MusicConstants.midiValues[note]!, 0.75);
      }
    });

    bassPart?.forEach((chord) {
      // String octaveIndex = '2';
      project.bassState.setVelocity(chord.position,
          MusicConstants.midiValues[chord.parentScaleKey]!, 0.99);
    });
    return project;
  }

  handleTogglePlayPause() {
    if (isPlaying) {
      sequence.pause();
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

  handleTempoChange(double nextTempo) {
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
    setState(() {});
  }

  Future<bool> popped() {
    handleStop();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getMainView());
  }

  _getMainView() {
    if (selectedTrack == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final isDrumTrackSelected = selectedTrack == tracks[0];
    return WillPopScope(
      onWillPop: () => popped(),
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: const Text("Play!"),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //FRETBOARD
              Fretboard(),
              //CHORDS
              const Expanded(flex: 2, child: Chords()),
              //SELECTED CHORD LIST
              ChordListWidget(),
              // SEQUENCER
              Opacity(opacity: 0.85, child: buildColumnWithData()),
              //CLEAR DRUMS BUTTON and TRANSPORT
              Container(
                // color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Row(children: [
                    //CLEAR DRUMS
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            clearTracks();
                          },
                          child: Opacity(
                            opacity: 0.8,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black26,
                                // Colors.orange[500].withOpacity(0.8),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // ),
                      ),
                    ),
                    //TRANSPORT
                    Transport(
                      isPlaying: isPlaying,
                      isLooping: isLooping,
                      onTogglePlayPause: handleTogglePlayPause,
                      onStop: handleStop,
                      onToggleLoop: handleToggleLoop,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColumnWithData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Drum Machine',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            )),
        DrumMachineWidget(
          selectedTempo: tempo,
          handleChange: handleTempoChange,
          track: tracks[0], //selectedTrack,
          stepCount: stepCount,
          currentStep: position.floor(),
          rowLabels: Constants.ROW_LABELS_DRUMS,
          columnPitches: Constants.ROW_PITCHES_DRUMS,
          stepSequencerState:
              trackStepSequencerStates[tracks[0].id] as StepSequencerState,
          handleVolumeChange: handleVolumeChange,
          handleVelocitiesChange: handleVelocitiesChange,
        ),
      ],
    );
  }
}
