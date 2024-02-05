import 'package:tonic/tonic.dart';

Map octatonics = {
  'Whole-Half': {
    'scaleStepsRoman': ['I', '♭II', '♭III', '♯III', '♯IV', 'V', '♭VI', '♭VII'],
    'triad': [Interval.P1, Interval.m3, Interval.d5],
    'tetrade': [Interval.P1, Interval.m3, Interval.d5, Interval.M6],
    'intervals': [0, 1, 3, 4, 6, 7, 9, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.m3,
      Interval.P4,
      Interval.d5,
      Interval.m6,
      Interval.M6,
      Interval.M7,
    ],
    'function': ['I', '♭II', '♭III', '♯III', '♯IV', 'V', '♭VI', '♭VII'],
    'chordType': ['°', '°', 'm', 'M', 'M', '°', 'm', 'm'],
  },
  'Half-Whole': {
    'scaleStepsRoman': ['I', '♭II', '♯II', '♯III', 'V', '♭VI', '♭VII'],
    'triad': [Interval.P1, Interval.m2, Interval.M3],
    'tetrade': [Interval.P1, Interval.m2, Interval.M3, Interval.P5],
    'intervals': [0, 1, 3, 4, 6, 7, 9, 10],
    'scaleDegrees': [
      Interval.P1,
      Interval.m2,
      Interval.m3,
      Interval.M3,
      Interval.A4,
      Interval.P5,
      Interval.M6,
      Interval.m7,
    ],
    'function': ['I', '♭II', '♯II', '♯III', 'V', '♭VI', '♭VII'],
    'chordType': ['°', '°', 'm', 'M', '°', '°', '°'],
  },
};
