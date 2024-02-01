import 'package:tonic/tonic.dart';

Map harmonicMinorModes = {
  'Harmonic Minor': {
    'scaleStepsRoman': ['I', 'II', '♭III', 'IV', 'V', '♭VI', 'VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.M7],
    'intervals': [0, 2, 3, 5, 7, 8, 11],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.m3,
      Interval.P4,
      Interval.P5,
      Interval.m6,
      Interval.M7
    ],
    'function': ['I', 'II', '♭III', 'IV', 'V', '♭VI', 'VII'],
    'chordType': ['m', '°', '+', 'm', '7', 'M', '°'],
  },
  'Locrian ♮6': {
    'scaleStepsRoman': ['I', '♭II', '♭III', 'IV', 'V', '♭VI', 'VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.M7],
    'intervals': [0, 1, 3, 5, 6, 9, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      Interval.m3,
      Interval.P4,
      Interval.d5,
      Interval.M6,
      Interval.m7
    ],
    'function': ['I', '♭II', '♭III', 'IV', '♭V', '♭VI', '♭VII'],
    'chordType': ['m', '°', 'm', 'm', 'm', 'M', 'M'],
  },
  'Ionian Augmented': {
    'scaleStepsRoman': ['I', 'II', 'III', '♯IV', '♯V', 'VI', 'VII'],
    'triad': [Interval.P1, Interval.M3, Interval.A5],
    'tetrade': [Interval.P1, Interval.M3, Interval.A5, Interval.M7],
    'intervals': [0, 2, 4, 5, 8, 9, 11],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.M3,
      Interval.P4,
      Interval.A5,
      Interval.M6,
      Interval.M7
    ],
    'function': ['I', 'II', 'iii', 'IV', '♯V', 'vi', 'vii'],
    'chordType': ['M', '+', '+', 'M', 'M', '°'],
  },
  'Romanian': {
    'scaleStepsRoman': ['I', 'II', '♭III', 'IV', 'V', '♭VI', 'VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.M7],
    'intervals': [0, 2, 3, 6, 7, 9, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.m3,
      Interval.A4,
      Interval.P5,
      Interval.M6,
      Interval.m7
    ],
    'function': ['I', 'II', '♭III', 'IV', 'V', '♭VI', 'VII'],
    'chordType': ['m', '°', '+', 'm', '7', 'M', '°'],
  },
  'Phrygian Dominant': {
    'scaleStepsRoman': ['I', '♭II', 'III', 'IV', 'V', '♭VI', '♭VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.M7],
    'intervals': [0, 1, 4, 5, 7, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      Interval.M3,
      Interval.P4,
      Interval.P5,
      Interval.m6,
      Interval.m7
    ],
    'function': ['I', '♭II', 'III', 'IV', 'V', '♭VI', '♭VII'],
    'chordType': ['m', 'm', '+', 'M', '7', 'm', '°'],
  },
  'Lydian ♯2': {
    'scaleStepsRoman': ['I', '♯II', 'III', '♯IV', 'V', 'VI', 'VII'],
    'triad': [Interval.P1, Interval.M3, Interval.P5],
    'tetrade': [Interval.P1, Interval.M3, Interval.P5, Interval.M7],
    'intervals': [0, 3, 4, 6, 7, 9, 11],
    'scaleDegrees': [
      Interval.P1,
      Interval.A2,
      Interval.M3,
      Interval.A4,
      Interval.P5,
      Interval.M6,
      Interval.M7
    ],
    'function': ['I', '♯II', 'III', '♯IV', 'V', 'VI', 'VII'],
    'chordType': ['M', '+', 'm', 'M', 'M', 'm', '°'],
  },
  'Altered Diminished)': {
    'scaleStepsRoman': ['I', '♭II', '♭III', '♭IV', '♭V', '♭VI', '♭VII'],
    'triad': [Interval.P1, Interval.m3, Interval.d5],
    'tetrade': [Interval.P1, Interval.m3, Interval.d5, Interval.m7],
    'intervals': [0, 1, 3, 4, 6, 8, 9],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      Interval.m3,
      Interval.d4,
      Interval.d5,
      Interval.m6,
      Interval.d7
    ],
    'function': ['I', '♭II', '♭III', '♭IV', '♭V', '♭VI', '♭VII'],
    'chordType': ['m', '°', 'm', 'm', 'm', 'M', 'M'],
  },
};
