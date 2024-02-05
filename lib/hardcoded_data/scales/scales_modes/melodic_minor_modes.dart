import 'package:tonic/tonic.dart';

Map<String, dynamic> melodicMinorModes = {
  'Jazz Minor': {
    'scaleStepsRoman': ['I', 'II', '♭III', 'IV', 'V', 'VI', 'VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.M7],
    'intervals': [0, 2, 3, 5, 7, 9, 11],
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
  'Dorian ♭2': {
    'scaleStepsRoman': ['I', 'II', '♭III', 'IV', 'V', 'VI', 'VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.M7],
    'intervals': [0, 1, 3, 5, 7, 9, 11],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      Interval.m3,
      Interval.P4,
      Interval.P5,
      Interval.M6,
      Interval.M7
    ],
    'function': ['i', 'ii', '♭III', 'IV', 'V', 'vi', 'vii'],
    'chordType': ['m', 'm', 'M', 'M', 'm', '°'],
  },
  'Lydian Augmented': {
    'scaleStepsRoman': ['I', 'II', 'III', '♯IV', '♯V', 'VI', 'VII'],
    'triad': [Interval.P1, Interval.M3, Interval.A5],
    'tetrade': [Interval.P1, Interval.M3, Interval.A5, Interval.M7],
    'intervals': [0, 2, 4, 6, 8, 9, 11],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.M3,
      Interval.A4,
      Interval.A5,
      Interval.M6,
      Interval.M7
    ],
    'function': ['I', 'II', 'iii', '♯IV', '♯V', 'vi', 'vii'],
    'chordType': ['M', '+', '+', 'M', 'M', '°'],
  },
  'Mixolydian ♭6': {
    'scaleStepsRoman': ['I', 'II', '♭III', 'IV', 'V', '♭VI', '♭VII'],
    'triad': [Interval.P1, Interval.M3, Interval.P5],
    'tetrade': [Interval.P1, Interval.M3, Interval.P5, Interval.M7],
    'intervals': [0, 2, 3, 5, 7, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.m3,
      Interval.P4,
      Interval.P5,
      Interval.m6,
      Interval.m7
    ],
    'function': ['I', 'II', '♭III', 'IV', 'V', '♭VI', '♭VII'],
    'chordType': ['M', 'm', 'm', 'M', 'M', 'm', '°'],
  },
  'Semilocrian': {
    'scaleStepsRoman': ['I', '♭II', '♭III', 'IV', '♭V', '♭VI', '♭VII'],
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
    'function': ['I', '♭II', '♭III', 'IV', '♭V', '♭VI', '♭VII'],
    'chordType': ['m', 'm', 'M', 'm', '°', 'M', 'M'],
  },
  'Superlocrian': {
    'scaleStepsRoman': ['I', '♭II', '♭III', '♭IV', '♭V', '♭VI', '♭VII'],
    'triad': [Interval.P1, Interval.m3, Interval.d5],
    'tetrade': [Interval.P1, Interval.m3, Interval.d5, Interval.m7],
    'intervals': [0, 1, 3, 4, 6, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      Interval.m3,
      Interval.d4,
      Interval.d5,
      Interval.m6,
      Interval.m7
    ],
    'function': ['I', '♭II', '♭III', '♭IV', '♭V', '♭VI', '♭VII'],
    'chordType': ['m', '°', 'm', 'm', 'm', 'M', 'M'],
  },
  // Repeat the structure for other modes of Melodic Minor
};
