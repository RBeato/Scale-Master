import 'package:equatable/equatable.dart';

abstract class JsonTo {
  Map<String, dynamic> toJson();
}

class Settings extends Equatable {
  bool isDarkHarmony;
  double musicKey;
  bool scaleAndChordsOption;
  String originScale;
  String chordVoicingOption;
  List chordVoicings;
  String bottomNoteStringOption;
  List bottomNoteStringList;
  String keyboardSound;
  bool bassIsSelected;
  String bassSound;
  String drumsSound;
  bool drumsIsSelected;
  bool showOnboarding;

  Settings({
    required this.isDarkHarmony,
    required this.bassSound,
    required this.bassIsSelected,
    required this.scaleAndChordsOption,
    required this.bottomNoteStringList,
    required this.bottomNoteStringOption,
    required this.chordVoicingOption,
    required this.chordVoicings,
    required this.drumsIsSelected,
    required this.drumsSound,
    required this.keyboardSound,
    required this.musicKey,
    required this.originScale,
    required this.showOnboarding,
  });

  @override
  List<Object> get props => [
        isDarkHarmony,
        bassIsSelected,
        bassSound,
        bottomNoteStringList,
        bottomNoteStringOption,
        chordVoicings,
        chordVoicingOption,
        drumsIsSelected,
        drumsSound,
        musicKey,
        originScale,
        showOnboarding,
      ];

  @override
  String toString() {
    return 'Settings: '
        '\n $isDarkHarmony'
        '\n $musicKey'
        '\n $scaleAndChordsOption'
        '\n $originScale'
        '\n $chordVoicingOption'
        '\n $chordVoicings'
        '\n $bottomNoteStringOption'
        '\n $bottomNoteStringList'
        '\n $keyboardSound'
        '\n $bassIsSelected'
        '\n $bassSound'
        '\n $drumsSound'
        '\n $drumsIsSelected'
        '\n $showOnboarding';
  }
}
