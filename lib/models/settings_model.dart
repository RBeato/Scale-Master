import 'package:equatable/equatable.dart';

abstract class JsonTo {
  Map<String, dynamic> toJson();
}

class Settings extends Equatable {
  double musicKey;
  String keyboardSound;
  String bassSound;
  String drumsSound;

  Settings({
    required this.musicKey,
    this.keyboardSound = 'Piano',
    this.bassSound = 'Double Bass',
    this.drumsSound = 'Acoustic',
  });

  @override
  List<Object> get props => [
        musicKey,
        keyboardSound,
        drumsSound,
        bassSound,
      ];

  @override
  String toString() {
    return 'Settings: '
        '\n $musicKey'
        '\n $keyboardSound'
        '\n $drumsSound'
        '\n $bassSound';
  }
}
