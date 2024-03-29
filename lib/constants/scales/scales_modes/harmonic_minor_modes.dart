import 'package:tonic/tonic.dart';

Map<String, dynamic> harmonicMinorModes = {
  'Harmonic Minor': {
    'scaleStepsRoman': ['I', 'II', '♭III', 'IV', 'V', '♭VI', 'VII'],
    'intervals': [0, 2, 3, 5, 7, 8, 11],
    'scaleDegrees': [
      Interval.P1,
      null,
      Interval.M2,
      Interval.m3,
      null,
      Interval.P4,
      null,
      Interval.P5,
      null,
      Interval.m6,
      Interval.M7,
      null,
    ],
    'function': ['I', 'II', '♭III', 'IV', 'V', '♭VI', 'VII'],
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
  },
  'Locrian ♯6': {
    'scaleStepsRoman': ['I', '♭II', '♭III', 'IV', '♭V', '♭VI', '♭VII'],
    'intervals': [0, 1, 3, 5, 6, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      null,
      Interval.m3,
      null,
      Interval.P4,
      Interval.d5,
      null,
      Interval.m6,
      null,
      Interval.m7,
      null,
    ],
    'function': ['I', '♭ii', '♭III', 'IV', '♭V', '♭VI', '♭VII'],
    'chordType': ['+', 'm', '7', 'M', '°', 'm', '°'],
  },
  'Ionian Augmented': {
    'scaleStepsRoman': ['I', 'II', 'III', '♯IV', '♯V', '♯VI', 'VII'],
    'intervals': [0, 2, 4, 5, 8, 9, 11],
    'scaleDegrees': [
      Interval.P1,
      null,
      Interval.M2,
      null,
      Interval.M3,
      null,
      Interval.A4,
      null,
      Interval.A5,
      null,
      Interval.A6,
      Interval.M7,
    ],
    'function': ['I', 'II', 'III', '♯IV', '♯V', '♯VI', 'VII'],
    'chordType': [
      '+',
      'm',
      '7',
      'M',
      '°',
      'm',
      '°',
    ],
  },
  'Romanian': {
    'scaleStepsRoman': ['I', 'II', '♭III', '♯IV', 'V', 'VI', '♭VII'],
    'intervals': [0, 2, 3, 6, 7, 9, 10],
    'scaleDegrees': [
      Interval.P1,
      null,
      Interval.M2,
      Interval.m3,
      null,
      null,
      Interval.A4,
      Interval.P5,
      null,
      Interval.M6,
      Interval.m7,
      null,
    ],
    'function': ['I', 'II', '♭III', '♯IV', 'V', 'VI', '♭VII'],
    'chordType': ['m', '7', 'M', '°', 'm', '°', '+'],
  },
  'Phrygian Dominant': {
    'scaleStepsRoman': ['I', '♭II', 'III', 'IV', 'V', '♭VI', '♭VII'],
    'intervals': [0, 1, 4, 5, 7, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      null,
      null,
      Interval.M3,
      Interval.P4,
      null,
      Interval.P5,
      Interval.m6,
      null,
      Interval.m7,
      null,
    ],
    'function': ['I', '♭II', 'III', 'IV', 'V', '♭VI', '♭VII'],
    'chordType': [
      '7',
      'M',
      '°',
      'm',
      '°',
      '+',
      'm',
    ],
  },
  'Lydian ♯2': {
    'scaleStepsRoman': ['I', 'II', '♯II', 'IV', 'V', '♭VI', 'VII'],
    'intervals': [0, 2, 3, 5, 7, 8, 11],
    'scaleDegrees': [
      Interval.P1,
      null,
      Interval.M2,
      null,
      null,
      Interval.A3,
      Interval.P4,
      null,
      Interval.P5,
      Interval.m6,
      null,
      Interval.M7,
    ],
    'function': ['I', 'II', '♯II', 'IV', 'V', '♭VI', 'VII'],
    'chordType': ['M', '°', 'm', '°', '+', 'm', '7'],
  },
  'Ultralocrian': {
    'scaleStepsRoman': ['I', '♭II', '♭III', '♭IV', '♭V', '♭VI', '♭VII'],
    'intervals': [0, 1, 3, 4, 6, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      null,
      Interval.m3,
      Interval.d4,
      null,
      Interval.d5,
      null,
      Interval.m6,
      null,
      Interval.m7,
      null,
    ],
    'function': ['I', '♭ii', '♭III', '♭IV', '♭V', '♭VI', '♭VII'],
    'chordType': ['°', 'm', '°', '+', 'm', '7', 'M'],
  },
};
