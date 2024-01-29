import 'package:tonic/tonic.dart';

class Scales {
  static List<String> options = [
    'Diatonic Major',
    'Melodic Minor',
    'Harmonic Minor',
  ];

  static Map data = {
    'Diatonic Major': {
      'scaleStepsRoman': [
        'I',
        'II',
        'III',
        'IV',
        'V',
        'VI',
        'VII',
      ],
      'triad': [
        Interval.P1,
        Interval.M3,
        Interval.P5,
      ],
      'tetrade': [
        Interval.P1,
        Interval.M3,
        Interval.P5,
        Interval.M7,
      ],
      'intervals': [0, 2, 4, 5, 7, 9, 11],
      'modeNames': [
        'Ionian',
        'Dorian',
        'Phrygian',
        'Lydian',
        'Mixolydian',
        'Aeolian',
        'Locrian'
      ],
      'scaleDegrees': [
        Interval.P1,
        Interval.M2,
        Interval.M3,
        Interval.P4,
        Interval.P5,
        Interval.M6,
        Interval.M7
      ],
      'function': ['I', 'ii', 'iii', 'IV', 'V', 'vi', 'vii'],
      'chordType': ['M', 'm', 'm', 'M', 'M', 'm', '°'],
    },
    'Melodic Minor': {
      'scaleStepsRoman': [
        'I',
        'II',
        '♭III',
        'IV',
        'V',
        'VI',
        'VII',
      ],
      'triad': [
        Interval.P1,
        Interval.m3,
        Interval.P5,
      ],
      'tetrade': [
        Interval.P1,
        Interval.m3,
        Interval.P5,
        Interval.M7,
      ],
      'intervals': [0, 2, 3, 5, 7, 9, 11],
      'modeNames': [
        'Jazz Minor',
        'Dorian ♭2',
        'Lydian Augmented',
        'Lydian Dominant',
        'Mixolydian ♭6',
        'Semilocrian',
        'Superlocrian'
      ],
      //Change information
      'scaleDegrees': [
        Interval.P1,
        Interval.M2,
        Interval.m3,
        Interval.P4,
        Interval.P5,
        Interval.M6,
        Interval.M7
      ],
      'function': ['I', 'ii', '♭iii', 'IV', 'V', 'vi', 'vii'],
      'chordType': ['M', 'm', 'M', 'm', 'M', 'm'],
    },
    'Harmonic Minor': {
      'scaleStepsRoman': [
        'I',
        'II',
        '♭III',
        'IV',
        'V',
        '♭VI',
        'VII',
      ],
      'triad': [
        Interval.P1,
        Interval.m3,
        Interval.P5,
      ],
      'tetrade': [
        Interval.P1,
        Interval.m3,
        Interval.P5,
        Interval.M7,
      ],
      'intervals': [0, 2, 3, 5, 7, 8, 11],
      'modeNames': [
        'Harmonic Minor',
        'Locrian ♯6',
        'Ionian Augmented',
        'Romanian',
        'Phrygian Dominant',
        'Lydian ♯2',
        'Ultralocrian'
      ],
      //Change information
      'scaleDegrees': [
        Interval.P1,
        Interval.M2,
        Interval.m3,
        Interval.P4,
        Interval.P5,
        Interval.m6,
        Interval.M7
      ],
      'function': ['I', 'ii', '♭III', 'iv', 'V', '♭VI', 'vii'],
      'chordType': ['m', '°', '+', 'm', '7', 'M', '°'],
      'originModeType': [
        'Harmonic Minor',
        'Locrian ♯6',
        'Ionian Augmented',
        'Romanian',
        'Phrygian Dominant',
        'Lydian ♯2',
        'Ultralocrian',
      ],
    }
  };
}
