import 'package:equatable/equatable.dart';

abstract class JsonTo {
  Map<String, dynamic> toJson();
}

class Settings extends Equatable {
  double musicKey;
  bool scaleAndChordsOption;
  String originScale;
  String chordVoicingOption;
  List chordVoicings;
  String bottomNoteStringOption;
  List bottomNoteStringList;

  Settings({
    required this.scaleAndChordsOption,
    required this.bottomNoteStringList,
    required this.bottomNoteStringOption,
    required this.chordVoicingOption,
    required this.chordVoicings,
    required this.musicKey,
    required this.originScale,
  });

  @override
  List<Object> get props => [
        bottomNoteStringList,
        bottomNoteStringOption,
        chordVoicings,
        chordVoicingOption,
        musicKey,
        originScale,
      ];

  @override
  String toString() {
    return 'Settings: '
        '\n $musicKey'
        '\n $scaleAndChordsOption'
        '\n $originScale'
        '\n $chordVoicingOption'
        '\n $chordVoicings'
        '\n $bottomNoteStringOption'
        '\n $bottomNoteStringList';
  }
}
