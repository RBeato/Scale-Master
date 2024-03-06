import 'package:tonic/tonic.dart';

Map hexatonics = {
  'Whole Tone': {
    'scaleStepsRoman': ['I', 'II', 'III', '♯IV', '♯V', '♯VI'],
    'triad': [Interval.P1, Interval.M2, Interval.M3],
    'tetrade': [Interval.P1, Interval.M2, Interval.M3, Interval.A4],
    'intervals': [0, 2, 4, 6, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.M3,
      Interval.A4,
      Interval.A5,
      Interval.A6,
    ],
    'function': ['I', 'II', 'III', '♯IV', '♯V', '♯VI'],
    'chordType': ['+', '+', '+', '+', '+', '+'],
  },
  'Major Hexatonic': {
    'scaleStepsRoman': ['I', 'II', 'III', 'IV', 'V', 'VI'],
    'triad': [Interval.P1, Interval.M3, Interval.A5],
    'tetrade': [Interval.P1, Interval.M3, Interval.A5, Interval.m7],
    'intervals': [0, 2, 4, 5, 7, 9],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.M3,
      Interval.P4,
      Interval.P5,
      Interval.M6,
    ],
    'function': ['I', 'II', 'III', 'IV', 'V', 'VI'],
    'chordType': ['M', 'M', 'M', 'M', 'M', 'M'],
  },
  'Minor Hexatonic': {
    'scaleStepsRoman': ['I', 'II', '♭III', 'IV', 'V', '♭VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.m7],
    'intervals': [0, 2, 3, 5, 7, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.m3,
      Interval.P4,
      Interval.P5,
      Interval.m7,
    ],
    'function': ['I', 'II', '♭III', 'IV', 'V', '♭VII'],
    'chordType': ['m', 'm', 'm', 'm', 'm', 'm'],
  },
  'Ritsu Onkai': {
    'scaleStepsRoman': ['I', '♭II', '♭III', 'IV', '♭VI', '♭VII'],
    'triad': [Interval.P1, Interval.m3, Interval.m6],
    'tetrade': [Interval.P1, Interval.m3, Interval.m6, Interval.m7],
    'intervals': [0, 1, 3, 5, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      Interval.m3,
      Interval.P4,
      Interval.m6,
      Interval.m7,
    ],
    'function': ['I', '♭II', '♭III', 'IV', '♭VI', '♭VII'],
    'chordType': ['°', '°', '°', '°', '°', '°'],
  },
  'Raga Kumud': {
    'scaleStepsRoman': ['I', 'II', 'III', 'V', 'VI', 'VII'],
    'triad': [Interval.P1, Interval.M3, Interval.P5],
    'tetrade': [Interval.P1, Interval.M3, Interval.P5, Interval.M7],
    'intervals': [0, 2, 4, 7, 9, 11],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.M3,
      Interval.P5,
      Interval.M6,
      Interval.M7,
    ],
    'function': ['I', 'II', 'III', 'V', 'VI', 'VII'],
    'chordType': ['M', 'M', 'M', 'M', 'M', 'M'],
  },
  'Mixolydian Hexatonic': {
    'scaleStepsRoman': ['I', 'II', 'IV', 'V', 'VI', '♭VII'],
    'triad': [Interval.P1, Interval.P4, Interval.P5],
    'tetrade': [Interval.P1, Interval.P4, Interval.P5, Interval.m7],
    'intervals': [0, 2, 5, 7, 9, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.P4,
      Interval.P5,
      Interval.M6,
      Interval.m7,
    ],
    'function': ['I', 'II', 'IV', 'V', 'VI', '♭VII'],
    'chordType': ['M', 'M', 'M', 'M', 'M', 'M'],
  },
  'Phrygian Hexatonic': {
    'scaleStepsRoman': ['I', '♭III', 'IV', 'V', '♭VI', '♭VII'],
    'triad': [Interval.P1, Interval.m3, Interval.P5],
    'tetrade': [Interval.P1, Interval.m3, Interval.P5, Interval.m7],
    'intervals': [0, 3, 5, 7, 8, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m3,
      Interval.P4,
      Interval.P5,
      Interval.m6,
      Interval.m7,
    ],
    'function': ['I', '♭III', 'IV', 'V', '♭VI', '♭VII'],
    'chordType': ['m', 'm', 'm', 'm', 'm', 'm'],
  },
};