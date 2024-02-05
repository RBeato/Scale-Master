import 'package:tonic/tonic.dart';

Map<String, dynamic> diatonicMajorModes = {
  'Ionian': {
    'scaleStepsRoman': ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII'],
    'triad': [Interval.P1, Interval.M3, Interval.P5],
    'tetrade': [Interval.P1, Interval.M3, Interval.P5, Interval.M7],
    'intervals': [0, 2, 4, 5, 7, 9, 11],
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
  'Dorian': {
    'scaleStepsRoman': ['I', 'II', '♭III', 'IV', 'V', 'VI', '♭VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.M7],
    'intervals': [0, 2, 3, 5, 7, 9, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.m3,
      Interval.P4,
      Interval.P5,
      Interval.M6,
      Interval.m7
    ],
    'function': ['I', 'ii', '♭III', 'IV', 'V', 'vi', '♭VII'],
    'chordType': ['m', 'm', 'M', 'm', 'm', 'M', '°'],
  },
  'Phrygian': {
    'scaleStepsRoman': ['I', '♭II', '♭III', 'IV', 'V', '♭VI', '♭VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.M7],
    'intervals': [0, 1, 3, 5, 7, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      Interval.m3,
      Interval.P4,
      Interval.P5,
      Interval.m6,
      Interval.m7
    ],
    'function': ['I', '♭ii', '♭III', 'IV', 'V', '♭VI', '♭VII'],
    'chordType': ['m', '°', 'm', 'm', 'M', 'm', 'm'],
  },
  'Lydian': {
    'scaleStepsRoman': ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII'],
    'triad': [Interval.P1, Interval.M3, Interval.P5],
    'tetrade': [Interval.P1, Interval.M3, Interval.P5, Interval.M7],
    'intervals': [0, 2, 4, 6, 7, 9, 11],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.M3,
      Interval.A4, // Augmented 4th (Lydian characteristic note)
      Interval.P5,
      Interval.M6,
      Interval.M7
    ],
    'function': ['I', 'II', 'III', '#IV', 'V', 'vi', 'vii'],
    'chordType': ['M', 'm', 'm', 'aug', 'M', 'm', '°'],
  }, // 'aug' represents augmented
  'Mixolydian': {
    'scaleStepsRoman': ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII'],
    'triad': [Interval.P1, Interval.M3, Interval.P5],
    'tetrade': [Interval.P1, Interval.M3, Interval.P5, Interval.m7],
    'intervals': [0, 2, 4, 5, 7, 9, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.M3,
      Interval.P4,
      Interval.P5,
      Interval.M6,
      Interval.m7
    ],
    'function': ['I', 'II', 'iii', 'IV', 'V', 'vi', 'vii'],
    'chordType': ['M', 'm', '°', 'M', 'm', 'm', 'M'],
  },
  'Aeolian': {
    'scaleStepsRoman': ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII'],
    'triad': [Interval.P1, Interval.M3, Interval.P5],
    'tetrade': [Interval.P1, Interval.M3, Interval.P5, Interval.M7],
    'intervals': [0, 2, 4, 5, 7, 9, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.m3,
      Interval.P4,
      Interval.P5,
      Interval.m6,
      Interval.m7
    ],
    'function': ['i', 'ii°', 'III', 'iv', 'v', 'VI', 'VII'],
    'chordType': ['m', '°', 'M', 'm', 'm', 'M', 'M']
  },
  'Locrian': {
    'scaleStepsRoman': ['I', 'II', '♭III', 'IV', '♭V', '♭VI', '♭VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.m7],
    'intervals': [0, 1, 3, 5, 6, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      Interval.m3,
      Interval.P4,
      Interval.d5,
      Interval.m6,
      Interval.m7
    ],
    'function': ['i°', '♭II', '♭iii', 'iv', '♭V', '♭vi', '♭VII'],
    'chordType': ['°', 'M', 'm', 'm', 'M', 'M', 'm']
  },
};
